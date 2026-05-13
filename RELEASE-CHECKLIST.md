# Release Checklist

## Pre-Release Verification

### 1. File Integrity
- [ ] All config files present (AGENTS.md, workflow-index.yaml, layers/, skills-source/, evals/, templates/)
- [ ] No broken symlinks in skills/ directories
- [ ] No platform-specific paths (e.g., hardcoded ~/.qoder/)
- [ ] All YAML files valid syntax

### 2. Content Quality
- [ ] AGENTS.md ~3.5KB
- [ ] No duplicate content across layers
- [ ] All skills have valid YAML frontmatter
- [ ] README.md has correct installation commands
- [ ] No placeholder text (YOUR_USERNAME, etc.)

### 3. Installation Scripts
- [ ] install.sh works on macOS/Linux
- [ ] install.ps1 works on Windows
- [ ] Backup mechanism works
- [ ] Verification step catches errors
- [ ] Platform auto-detection works

### 4. Cross-Platform Compatibility
- [ ] Claude Code: `~/.claude/` path works
- [ ] Codex: `~/.codex/` path works
- [ ] Qoder: `~/.qoder/` path works
- [ ] Skills symlinks created correctly

### 5. Documentation
- [ ] README.md complete
- [ ] ARCHITECTURE.md complete
- [ ] LICENSE present
- [ ] .gitignore appropriate

### 6. GitHub Ready
- [ ] Repository initialized
- [ ] First commit clean (only config files)
- [ ] No sensitive data in history
- [ ] Branch protection rules (optional)

## Post-Release Tasks

### 1. Initial Promotion
- [ ] Share on Twitter/X with architecture diagram
- [ ] Post to r/ClaudeCode with effectiveness data
- [ ] Post to r/ChatGPT with comparison table
- [ ] Share on LinkedIn

### 2. Community Building
- [ ] Enable Discussions on GitHub
- [ ] Create CONTRIBUTING.md
- [ ] Create issue templates
- [ ] Set up GitHub Pages for docs

### 3. Feedback Collection
- [ ] Monitor issues for first week
- [ ] Collect effectiveness data from users
- [ ] Identify most-requested features
- [ ] Plan v1.1 based on feedback

### 4. Ecosystem Growth
- [ ] Accept community skills PRs
- [ ] Add more evals
- [ ] Create skill marketplace
- [ ] Integrate with more platforms

## Version History

### v1.0.0 (Initial Release)
- Core progressive disclosure architecture
- 10 specialized routes
- 10 strategy layers
- 9 adapter skills
- Constructive dissent (anti-sycophancy)
- Cross-platform support (Claude Code, Codex, Qoder)
- Auto-install scripts
