<#
BBWAAS SAFE SYNC

Push/pull approved BBWAAS work between local BrainHub and the GitHub proof mirror.

Modes:
  .\bbwaas-safe-sync.ps1 -Mode Status
  .\bbwaas-safe-sync.ps1 -Mode Push
  .\bbwaas-safe-sync.ps1 -Mode Pull

Guardrails:
- Allowlist-based sync only.
- Excludes common secrets and private folders.
- Does not run agents.
- Does not touch DNS, hosting, payments, wallets, or API keys.
#>

param(
  [ValidateSet("Status", "Push", "Pull")]
  [string]$Mode = "Status",

  [string]$BrainHub = "$env:USERPROFILE\Documents\BrainHub",
  [string]$RepoPath = "$env:USERPROFILE\Documents\BrainHub\bbwaas-static-proof",
  [string]$RepoUrl = "https://github.com/Oc2cO/bbwaas-static-proof.git"
)

$ErrorActionPreference = "Stop"

$Workspace = Join-Path $BrainHub "00_MASTER_FRONT_DOOR\AGENT_WORKSPACE"
$MirrorWorkspace = Join-Path $RepoPath "AGENT_WORKSPACE"
$ToolMirror = Join-Path $RepoPath "LOCAL_TOOLS"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

$AllowedWorkspaceDirs = @(
  "PACKETS",
  "AGENT_REPORTS",
  "CHECKER_REPORTS",
  "PR_QUEUE",
  "NETWORK_STACK",
  "COMPLETED"
)

$AllowedWorkspaceFiles = @(
  "README.md"
)

$AllowedBrainHubFiles = @(
  "00_MASTER_FRONT_DOOR\BBWAAS_PIN_BOARD_CURRENT.md",
  "00_MASTER_FRONT_DOOR\BRAINHUB_COMMAND_ROOM.html"
)

$AllowedToolDirs = @(
  "bbwaas_sidecar_panel"
)

$ExcludeDirs = @(
  ".git",
  "node_modules",
  ".venv",
  "venv",
  "__pycache__",
  "PRIVATE",
  "PRIVATE_NOTES",
  "PERSONAL",
  "FAMILY",
  "HEALTH",
  "SECRETS",
  "SECRET",
  "WALLETS",
  "KEYS"
)

$ExcludeFiles = @(
  ".env",
  ".env.*",
  "*.pem",
  "*.key",
  "*secret*",
  "*token*",
  "*credential*",
  "*password*",
  "*wallet*",
  "cookies*",
  "*.sqlite",
  "*.db"
)

function Require-Git {
  $git = Get-Command git -ErrorAction SilentlyContinue
  if (-not $git) {
    throw "git is not installed or not on PATH. Install Git for Windows first."
  }
}

function Ensure-Repo {
  Require-Git
  if (-not (Test-Path $RepoPath)) {
    Write-Host "Cloning repo to $RepoPath"
    git clone $RepoUrl $RepoPath
  }
  if (-not (Test-Path (Join-Path $RepoPath ".git"))) {
    throw "RepoPath exists but is not a git repository: $RepoPath"
  }
}

function Invoke-RoboCopySafe($Source, $Dest) {
  if (-not (Test-Path $Source)) {
    Write-Host "SKIP missing: $Source"
    return
  }
  New-Item -ItemType Directory -Force -Path $Dest | Out-Null
  robocopy $Source $Dest /E /XD $ExcludeDirs /XF $ExcludeFiles /NFL /NDL /NJH /NJS /NP | Out-Null
  $code = $LASTEXITCODE
  if ($code -gt 7) {
    throw "robocopy failed with exit code $code for $Source -> $Dest"
  }
}

function Copy-FileSafe($Source, $Dest) {
  if (-not (Test-Path $Source)) {
    Write-Host "SKIP missing file: $Source"
    return
  }
  $fileName = Split-Path $Source -Leaf
  foreach ($pattern in $ExcludeFiles) {
    if ($fileName -like $pattern) {
      Write-Host "SKIP excluded file: $Source"
      return
    }
  }
  New-Item -ItemType Directory -Force -Path (Split-Path $Dest -Parent) | Out-Null
  Copy-Item $Source $Dest -Force
}

function Push-SafeMirror {
  Ensure-Repo

  Push-Location $RepoPath
  git pull --ff-only
  Pop-Location

  New-Item -ItemType Directory -Force -Path $MirrorWorkspace | Out-Null

  foreach ($dir in $AllowedWorkspaceDirs) {
    Invoke-RoboCopySafe (Join-Path $Workspace $dir) (Join-Path $MirrorWorkspace $dir)
  }

  foreach ($file in $AllowedWorkspaceFiles) {
    Copy-FileSafe (Join-Path $Workspace $file) (Join-Path $MirrorWorkspace $file)
  }

  foreach ($rel in $AllowedBrainHubFiles) {
    Copy-FileSafe (Join-Path $BrainHub $rel) (Join-Path $RepoPath $rel)
  }

  foreach ($toolDir in $AllowedToolDirs) {
    Invoke-RoboCopySafe (Join-Path $BrainHub $toolDir) (Join-Path $ToolMirror $toolDir)
  }

  Push-Location $RepoPath
  git status --short
  git add AGENT_WORKSPACE LOCAL_TOOLS 00_MASTER_FRONT_DOOR scripts BBWAAS_PIN_BOARD_CURRENT.md 2>$null
  $changes = git status --porcelain
  if ([string]::IsNullOrWhiteSpace($changes)) {
    Write-Host "No safe mirror changes to commit."
  } else {
    git commit -m "BBWAAS safe mirror sync $Stamp"
    git push
  }
  Pop-Location
}

function Pull-SafeMirror {
  Ensure-Repo

  Push-Location $RepoPath
  git pull --ff-only
  Pop-Location

  $BackupRoot = Join-Path $BrainHub "00_MASTER_FRONT_DOOR\SYNC_BACKUPS\$Stamp"
  New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null

  foreach ($dir in $AllowedWorkspaceDirs) {
    $localDir = Join-Path $Workspace $dir
    if (Test-Path $localDir) {
      Invoke-RoboCopySafe $localDir (Join-Path $BackupRoot "AGENT_WORKSPACE\$dir")
    }
    Invoke-RoboCopySafe (Join-Path $MirrorWorkspace $dir) $localDir
  }

  foreach ($file in $AllowedWorkspaceFiles) {
    $localFile = Join-Path $Workspace $file
    if (Test-Path $localFile) {
      Copy-FileSafe $localFile (Join-Path $BackupRoot "AGENT_WORKSPACE\$file")
    }
    Copy-FileSafe (Join-Path $MirrorWorkspace $file) $localFile
  }

  foreach ($rel in $AllowedBrainHubFiles) {
    $localFile = Join-Path $BrainHub $rel
    $repoFile = Join-Path $RepoPath $rel
    if (Test-Path $localFile) {
      Copy-FileSafe $localFile (Join-Path $BackupRoot $rel)
    }
    Copy-FileSafe $repoFile $localFile
  }

  Write-Host "Pull complete. Local backup saved at $BackupRoot"
}

function Show-Status {
  Write-Host "BrainHub:        $BrainHub"
  Write-Host "Workspace:       $Workspace"
  Write-Host "RepoPath:        $RepoPath"
  Write-Host "RepoUrl:         $RepoUrl"
  Write-Host "MirrorWorkspace: $MirrorWorkspace"
  Write-Host "Mode:            $Mode"
  Write-Host ""
  Write-Host "Allowed workspace dirs: $($AllowedWorkspaceDirs -join ', ')"
  Write-Host "Allowed tools:          $($AllowedToolDirs -join ', ')"
  Write-Host "Excluded dirs:          $($ExcludeDirs -join ', ')"
  Write-Host "Excluded files:         $($ExcludeFiles -join ', ')"
}

Show-Status

switch ($Mode) {
  "Status" { return }
  "Push" { Push-SafeMirror }
  "Pull" { Pull-SafeMirror }
}
