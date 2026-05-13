# Target-State Engineering OS - Windows Installer
# Detects platform and installs to correct path

$ErrorActionPreference = "Stop"

Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Blue
Write-Host "║  Target-State Engineering OS Installer             ║" -ForegroundColor Blue
Write-Host "║  Claude Code | Codex | Qoder                       ║" -ForegroundColor Blue
Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Blue
Write-Host ""

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigDir = Join-Path $ScriptDir "..\config"

# Detect platform
Write-Host "Detecting platform..." -ForegroundColor Blue

$Platform = ""
$TargetPath = ""

# Check for Qoder (most likely on Windows)
if (Test-Path "$env:USERPROFILE\.qoder") {
    $Platform = "qoder"
    $TargetPath = "$env:USERPROFILE\.qoder"
}
# Check for Codex
elseif (Test-Path "$env:USERPROFILE\.codex") {
    $Platform = "codex"
    $TargetPath = "$env:USERPROFILE\.codex"
}
# Check for Claude Code
elseif (Test-Path "$env:USERPROFILE\.claude") {
    $Platform = "claude"
    $TargetPath = "$env:USERPROFILE\.claude"
}

if ([string]::IsNullOrEmpty($Platform)) {
    Write-Host "No platform detected. Please choose:" -ForegroundColor Yellow
    Write-Host "1) Claude Code ($env:USERPROFILE\.claude)"
    Write-Host "2) Codex ($env:USERPROFILE\.codex)"
    Write-Host "3) Qoder ($env:USERPROFILE\.qoder)"
    $Choice = Read-Host "Choose [1-3]"

    switch ($Choice) {
        "1" { $Platform = "claude"; $TargetPath = "$env:USERPROFILE\.claude" }
        "2" { $Platform = "codex"; $TargetPath = "$env:USERPROFILE\.codex" }
        "3" { $Platform = "qoder"; $TargetPath = "$env:USERPROFILE\.qoder" }
        default { Write-Host "Invalid choice"; exit 1 }
    }
}
else {
    Write-Host "✓ Detected: $Platform at $TargetPath" -ForegroundColor Green
}

# Verify config exists
if (-not (Test-Path $ConfigDir)) {
    Write-Host "✗ Error: config/ directory not found at $ConfigDir" -ForegroundColor Red
    exit 1
}

# Backup existing config
if ((Test-Path "$TargetPath\AGENTS.md") -or (Test-Path "$TargetPath\workflow-index.yaml")) {
    Write-Host "Backing up existing configuration..." -ForegroundColor Yellow
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupPath = "$TargetPath.backup.$Timestamp"
    
    if (Test-Path $TargetPath) {
        Copy-Item -Path $TargetPath -Destination $BackupPath -Recurse -Force
        Write-Host "✓ Backup saved to: $BackupPath" -ForegroundColor Green
    }
}

# Install
Write-Host "Installing Target-State Engineering OS..." -ForegroundColor Blue

# Create target if not exists
if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
}

# Copy core files
Copy-Item "$ConfigDir\AGENTS.md" "$TargetPath\" -Force
Copy-Item "$ConfigDir\workflow-index.yaml" "$TargetPath\" -Force
Write-Host "✓ Core files copied" -ForegroundColor Green

# Copy directories
$Dirs = @("layers", "skills-source", "evals", "templates", "rules")
foreach ($Dir in $Dirs) {
    $SrcDir = Join-Path $ConfigDir $Dir
    $DestDir = Join-Path $TargetPath $Dir
    
    if (Test-Path $SrcDir) {
        if (-not (Test-Path $DestDir)) {
            New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
        }
        Copy-Item "$SrcDir\*" $DestDir -Recurse -Force
        Write-Host "✓ $Dir/ copied" -ForegroundColor Green
    }
}

# Platform-specific: Create skills symlinks for Qoder
if ($Platform -eq "qoder") {
    Write-Host "Setting up Qoder skills symlinks..." -ForegroundColor Blue
    $SkillsDir = Join-Path $TargetPath "skills"
    
    if (-not (Test-Path $SkillsDir)) {
        New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
    }
    
    $AdaptersDir = Join-Path $TargetPath "skills-source\adapters"
    if (Test-Path $AdaptersDir) {
        Get-ChildItem $AdaptersDir -Directory | ForEach-Object {
            $SkillName = $_.Name
            $LinkPath = Join-Path $SkillsDir $SkillName
            
            # Remove existing link/file
            if (Test-Path $LinkPath) {
                Remove-Item $LinkPath -Recurse -Force
            }
            
            # Create symlink
            New-Item -ItemType Junction -Path $LinkPath -Target $_.FullName | Out-Null
        }
    }
    Write-Host "✓ Qoder skills linked" -ForegroundColor Green
}

# Verify installation
Write-Host ""
Write-Host "Verifying installation..." -ForegroundColor Blue
$Errors = 0

if (-not (Test-Path "$TargetPath\AGENTS.md")) { Write-Host "✗ AGENTS.md missing" -ForegroundColor Red; $Errors++ }
if (-not (Test-Path "$TargetPath\workflow-index.yaml")) { Write-Host "✗ workflow-index.yaml missing" -ForegroundColor Red; $Errors++ }
if (-not (Test-Path "$TargetPath\layers")) { Write-Host "✗ layers/ missing" -ForegroundColor Red; $Errors++ }
if (-not (Test-Path "$TargetPath\skills-source")) { Write-Host "✗ skills-source/ missing" -ForegroundColor Red; $Errors++ }

if ($Errors -eq 0) {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  ✓ Installation Complete!                          ║" -ForegroundColor Green
    Write-Host "║  Platform: $Platform" -ForegroundColor Green
    Write-Host "║  Path: $TargetPath" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Blue
    Write-Host "  1. Restart your IDE/terminal"
    Write-Host "  2. Verify: Check AGENTS.md is loaded"
    Write-Host "  3. Try a tiny_task: Ask 'What does this function do?'"
}
else {
    Write-Host ""
    Write-Host "✗ Installation completed with $Errors error(s)" -ForegroundColor Red
    exit 1
}
