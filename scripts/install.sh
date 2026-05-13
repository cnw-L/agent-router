#!/bin/bash
# Target-State Engineering OS - Cross-Platform Installer
# Detects platform and installs to correct path

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Target-State Engineering OS Installer             ║${NC}"
echo -e "${BLUE}║  Claude Code | Codex | Qoder                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="${SCRIPT_DIR}/../config"

# Detect platform
detect_platform() {
    local platform=""
    local target_path=""

    # Check for Claude Code
    if command -v claude &> /dev/null || [ -d "$HOME/.claude" ]; then
        platform="claude"
        target_path="$HOME/.claude"
    # Check for Codex
    elif [ -d "$HOME/.codex" ]; then
        platform="codex"
        target_path="$HOME/.codex"
    # Check for Qoder
    elif [ -d "$HOME/.qoder" ]; then
        platform="qoder"
        target_path="$HOME/.qoder"
    fi

    echo "$platform|$target_path"
}

# Ask user if auto-detect fails or for confirmation
ask_platform() {
    echo -e "${YELLOW}Multiple platforms detected. Please choose:${NC}"
    echo "1) Claude Code (~/.claude/)"
    echo "2) Codex (~/.codex/)"
    echo "3) Qoder (~/.qoder/)"
    read -p "Choose [1-3]: " choice

    case $choice in
        1) echo "claude|$HOME/.claude" ;;
        2) echo "codex|$HOME/.codex" ;;
        3) echo "qoder|$HOME/.qoder" ;;
        *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
    esac
}

# Main installation
echo -e "${BLUE}Detecting platform...${NC}"
result=$(detect_platform)
platform=$(echo $result | cut -d'|' -f1)
target_path=$(echo $result | cut -d'|' -f2)

if [ -z "$platform" ]; then
    echo -e "${YELLOW}No platform auto-detected. Please select:${NC}"
    result=$(ask_platform)
    platform=$(echo $result | cut -d'|' -f1)
    target_path=$(echo $result | cut -d'|' -f2)
else
    echo -e "${GREEN}✓ Detected: $platform at $target_path${NC}"
fi

# Verify config exists
if [ ! -d "$CONFIG_DIR" ]; then
    echo -e "${RED}✗ Error: config/ directory not found${NC}"
    exit 1
fi

# Backup existing config
if [ -d "$target_path" ] && [ -f "$target_path/AGENTS.md" ]; then
    echo -e "${YELLOW}Backing up existing configuration...${NC}"
    backup_path="$target_path.backup.$(date +%Y%m%d_%H%M%S)"
    cp -r "$target_path" "$backup_path" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup saved to: $backup_path${NC}"
fi

# Install
echo -e "${BLUE}Installing Target-State Engineering OS...${NC}"

# Copy core files
cp "$CONFIG_DIR/AGENTS.md" "$target_path/"
cp "$CONFIG_DIR/workflow-index.yaml" "$target_path/"

# Copy directories
if [ -d "$CONFIG_DIR/layers" ]; then
    mkdir -p "$target_path/layers"
    cp -r "$CONFIG_DIR/layers/"* "$target_path/layers/"
fi

if [ -d "$CONFIG_DIR/skills-source" ]; then
    mkdir -p "$target_path/skills-source"
    cp -r "$CONFIG_DIR/skills-source/"* "$target_path/skills-source/"
fi

if [ -d "$CONFIG_DIR/evals" ]; then
    mkdir -p "$target_path/evals"
    cp -r "$CONFIG_DIR/evals/"* "$target_path/evals/"
fi

if [ -d "$CONFIG_DIR/templates" ]; then
    mkdir -p "$target_path/templates"
    cp -r "$CONFIG_DIR/templates/"* "$target_path/templates/"
fi

if [ -d "$CONFIG_DIR/rules" ]; then
    mkdir -p "$target_path/rules"
    cp -r "$CONFIG_DIR/rules/"* "$target_path/rules/"
fi

# Platform-specific: Create skills symlinks for Qoder
if [ "$platform" = "qoder" ]; then
    echo -e "${BLUE}Setting up Qoder skills symlinks...${NC}"
    mkdir -p "$target_path/skills"

    # Link adapter skills
    if [ -d "$target_path/skills-source/adapters" ]; then
        for skill in "$target_path/skills-source/adapters"/*/; do
            skill_name=$(basename "$skill")
            ln -sf "$target_path/skills-source/adapters/$skill_name" "$target_path/skills/$skill_name" 2>/dev/null || true
        done
    fi

    echo -e "${GREEN}✓ Qoder skills linked${NC}"
fi

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
errors=0

[ -f "$target_path/AGENTS.md" ] || { echo -e "${RED}✗ AGENTS.md missing${NC}"; errors=$((errors+1)); }
[ -f "$target_path/workflow-index.yaml" ] || { echo -e "${RED}✗ workflow-index.yaml missing${NC}"; errors=$((errors+1)); }
[ -d "$target_path/layers" ] || { echo -e "${RED}✗ layers/ missing${NC}"; errors=$((errors+1)); }
[ -d "$target_path/skills-source" ] || { echo -e "${RED}✗ skills-source/ missing${NC}"; errors=$((errors+1)); }

if [ $errors -eq 0 ]; then
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✓ Installation Complete!                          ║${NC}"
    echo -e "${GREEN}║  Platform: $platform${NC}"
    echo -e "${GREEN}║  Path: $target_path${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Restart your IDE/terminal"
    echo "  2. Verify: Check AGENTS.md is loaded"
    echo "  3. Try a tiny_task: Ask 'What does this function do?'"
else
    echo ""
    echo -e "${RED}✗ Installation completed with $errors error(s)${NC}"
    exit 1
fi
