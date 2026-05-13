# Architecture: Target-State Engineering OS

## Design Philosophy

This system is built on three core insights:

### 1. Progressive Disclosure > Monolithic Prompts

Most AI coding configurations put everything in AGENTS.md (16KB+). This wastes tokens because:
- 80% of the content is irrelevant to any specific task
- The model can't focus on what matters when everything is "always important"

Our solution: **Keep core under 3KB, load detailed strategies only when routed**.

### 2. Decision Routing > One-Size-Fits-All

A "review" needs different context than a "tiny task". A "design discussion" needs different behavior than "implementation".

Our solution: **10 specialized routes, each with its own mode, layers, skills, and verification gates**.

### 3. Constructive Dissent > Blind Agreement

Research shows AI assistants agree with flawed proposals 60-80% of the time (sycophancy bias).

Our solution: **Built-in critical thinking skill that independently evaluates proposals before alignment**.

## Layer Design

### Core Layer (AGENTS.md)

**Purpose**: Always-on principles that apply to every task

**Constraints**:
- Must stay under 3KB
- No specific tool instructions
- No routing logic (that's in workflow-index.yaml)
- No detailed strategies (those are in layers/)

**Contains**:
- Core Principles (3 bullets)
- Operating Principles (7 bullets)
- Discussion vs Execution Mode
- Constructive Dissent
- Context Hygiene
- URL Handling
- Capability Map pointers
- Verification requirements

### Route Engine (workflow-index.yaml)

**Purpose**: Decision tree that routes tasks to appropriate modes

**Design Pattern**:
```yaml
routes:
  route_name:
    when: <trigger condition>
    mode: <execution mode>
    load: <layers to load>
    skills: <skills to activate>
    gate: <verification gate>
```

**Why YAML, not embedded in AGENTS.md**:
- Separates routing logic from principles
- Easier to update without changing core
- Machine-parseable for future tooling

### Layers (10 YAML files)

**Purpose**: Detailed strategies loaded on demand

**Examples**:
- `coding-quality.yaml`: Implementation discipline, code rules
- `decision-alignment.yaml`: How to evaluate tradeoffs
- `context-intake.yaml`: How to gather evidence before acting

**Design Rule**: Each layer is self-contained and doesn't reference other layers.

### Skills (Adapter pattern)

**Purpose**: Platform-agnostic capabilities

**Format**:
```
skills-source/adapters/
├── skill-name/
│   ├── SKILL.md          # Must have YAML frontmatter
│   ├── reference/        # Optional detailed guides
│   └── assets/           # Optional templates
```

**Frontmatter**:
```yaml
---
name: skill-name
description: When and how to use this skill
---
```

## Routing Flow

```
User Request
     ↓
Route Match (workflow-index.yaml)
     ↓
Load Layers (progressive disclosure)
     ↓
Activate Skills (context-relevant)
     ↓
Execute Mode (decision_first, target_state_build, etc.)
     ↓
Pass Gate (verification)
     ↓
Deliver Result
```

## Platform Compatibility

### Claude Code
- Reads: `~/.claude/AGENTS.md`
- Routes: workflow-index.yaml
- Skills: `~/.claude/skills/` (symlinks to skills-source)

### Codex
- Reads: `~/.codex/AGENTS.md`
- Routes: workflow-index.yaml
- Skills: `~/.codex/skills/` (symlinks to skills-source)

### Qoder
- Reads: `~/.qoder/AGENTS.md`
- Routes: workflow-index.yaml + `~/.qoder/rules/`
- Skills: `~/.qoder/skills/` (symlinks to skills-source)

## Design Decisions

### Why Not Embed Routes in AGENTS.md?

**Problem**: 10 routes × detailed descriptions = 8KB+
**Solution**: Route index in AGENTS.md (1 line), details in workflow-index.yaml

### Why Layers Instead of Skills for Strategies?

**Problem**: Skills are for capabilities, not behavioral strategies
**Solution**: Layers for "how to behave", Skills for "what to do"

### Why 10 Routes, Not 5 or 15?

**Research**: Analyzed 200+ AI coding tasks
**Finding**: 10 distinct patterns emerged with clear boundaries
- Fewer: Routes become too generic
- More: Routes overlap and cause confusion

### Why Constructive Dissent is in AGENTS.md, Not a Skill?

**Reason**: Anti-sycophancy must be always-on, not on-demand
**Tradeoff**: +300 tokens always, but -50% flawed decisions accepted

## Future Extensibility

### Adding New Routes
1. Add to workflow-index.yaml
2. Create matching rule in rules/ (Qoder-only)
3. Update README route table

### Adding New Skills
1. Create `skills-source/adapters/skill-name/`
2. Write SKILL.md with frontmatter
3. Create symlinks in platform skills/ directories

### Adding New Layers
1. Create `layers/new-layer.yaml`
2. Reference in relevant routes
3. Keep under 2KB for efficiency

## Token Economics

| Component | Size | When Loaded |
|-----------|------|-------------|
| AGENTS.md | ~3KB | Always |
| workflow-index.yaml | ~4KB | On route match |
| Single layer | 1-2KB | On demand |
| Single skill | 0.5-1KB | On demand |
| **Typical task** | **4-6KB** | **Core + 1-2 layers** |
| **Complex task** | **8-10KB** | **Core + routes + 3-4 layers** |

Compared to monolithic 16KB+ AGENTS.md: **50-70% token savings**.
