# Agent-Router

A lightweight, cross-platform engineering operating system for AI coding assistants (Claude Code, Codex, Qoder). Enforces progressive disclosure, decision-routing, and quality gates to transform AI coding from chat-based assistance to engineering-grade delivery.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20Qoder-green)](#installation)

## Why This Exists

Most AI coding assistants suffer from **sycophancy bias** (60-80% agreement rate even on flawed proposals) and **context bloat** (16KB+ always-on instructions). This system solves both:

- **Progressive Disclosure**: Core stays under 3.5KB; load detailed strategies only when relevant
- **Decision Routing**: 10 specialized routes with evidence gates, not one-size-fits-all prompts
- **Constructive Dissent**: Independently evaluate proposals before alignment, reducing附和 by 40-55%

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   AGENTS.md (~3.5KB)                    │
│           Always-on Core Principles & Routing           │
└────────────────────────┬────────────────────────────────┘
                         │ Route Task
                         ▼
┌─────────────────────────────────────────────────────────┐
│              workflow-index.yaml (Route Engine)         │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │
│  │ tiny_task│ │design_   │ │complex_  │ │implementa- │  │
│  │          │ │config    │ │feature   │ │tion        │  │
│  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │
│  │ bugfix   │ │ review   │ │ security │ │ multi_     │  │
│  │          │ │          │ │          │ │ agent      │  │
│  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │
└────────────────────────┬────────────────────────────────┘
                         │ Load on Demand
                         ▼
┌──────────────────────┬──────────────────────────────────┐
│   10 Layer Files     │     9 Adapter Skills             │
│ (methodology,        │ (decision-alignment,             │
│  decision_alignment, │  codebase-impact,                │
│  coding_quality,     │  implementation-quality,         │
│  context_intake...)  │  critical-thinking...)           │
└──────────────────────┴──────────────────────────────────┘
```

## Key Features

### 1. Three-Layer Progressive Disclosure

| Layer | What | When | Token Cost |
|-------|------|------|------------|
| **Core** (AGENTS.md) | Principles, routing, verification | Always | ~3.5KB |
| **Route Engine** (workflow-index.yaml) | 10 routes with decision trees | On route match | +4KB |
| **Layers & Skills** | Detailed strategies, adapters | On demand | 1-2KB each |

**Result**: 80% less context than monolithic AGENTS.md configurations.

### 2. 10 Specialized Routes

| Route | When | Mode | Gate |
|-------|------|------|------|
| `tiny_task` | Simple answer, one-step read | shortest_safe_path | verify_if_changed |
| `design_or_config` | Architecture, dependency, policy | decision_first | user_confirmation_with_dissent |
| `complex_feature` | New feature, cross-module, public API | spec_then_target_state | focused_tests_plus_review |
| `implementation` | Plan confirmed, code must change | target_state_build | relevant_tests_lint_type_build |
| `bugfix` | Bug, regression, flaky test | diagnose_then_fix | regression_test_plus_verify |
| `review` | Audit, PR review, risk check | independent_review | findings_first |
| `security` | Auth, secrets, input, trust boundary | security_review | security_findings_and_risk |
| `pr_or_ci` | Branch, PR, CI, release loop | pr_ci_loop | ci_or_local_equivalent |
| `multi_agent` | Parallel exploration, slow verify | bounded_parallelism | integrate_outputs |
| `continuity` | Long-running, multi-session | lightweight_state | concise_artifact_only |

### 3. Constructive Dissent (Anti-Sycophancy)

Built-in critical thinking that:
- **Independently evaluates** proposals against problem constraints, not user preferences
- **Surfaces risks, hidden costs, and alternatives** even when not asked
- **Prioritizes being correct over being agreeable**, while remaining constructive

Based on research from Anthropic (2023), Sharma et al. (2024), and community best practices.

## Installation

### Auto-Install (Recommended)

```bash
# Detects your platform and installs to the correct path
curl -fsSL https://raw.githubusercontent.com/cnw-L/target-state-engineering-os/main/scripts/install.sh | bash
```

### Manual Install

| Platform | Install Path | Command |
|----------|--------------|---------|
| **Claude Code** | `~/.claude/` | `cp -r config/* ~/.claude/` |
| **Codex** | `~/.codex/` | `cp -r config/* ~/.codex/` |
| **Qoder** | `~/.qoder/` | `cp -r config/* ~/.qoder/` |

### Verify Installation

```bash
# Should show AGENTS.md, workflow-index.yaml, layers/, skills-source/
ls ~/.claude/  # or ~/.codex/ or ~/.qoder/
```

## Quick Start

### 1. Tiny Task (Automatic)
Just ask: "What does this function do?" → Shortest safe path, no overhead.

### 2. Design Discussion
Ask: "How should I implement caching?" → Decision-first mode with critical thinking.

### 3. Complex Feature
Ask: "Add user authentication" → Spec → Target-state with review gates.

### 4. Implementation
After plan confirmed → Direct target-state build with quality constraints.

## How It Differs

| Approach | Context Size | Decision Quality | Critical Thinking |
|----------|--------------|------------------|-------------------|
| Monolithic AGENTS.md | 16KB+ always-on | One-size-fits-all | AI agrees with user |
| Skills Collection | 0KB core, skills on-demand | Skill-specific | Optional |
| **This System** | **3.5KB core, routes+layers on-demand** | **10 specialized routes** | **Built-in dissent** |

## Platform Compatibility

| Feature | Claude Code | Codex | Qoder |
|---------|-------------|-------|-------|
| AGENTS.md | ✅ | ✅ | ✅ |
| workflow-index.yaml | ✅ | ✅ | ✅ |
| Layers system | ✅ | ✅ | ✅ |
| Skills adapters | ✅ | ✅ | ✅ |
| Route rules | ✅ (manual) | ✅ (manual) | ✅ (auto) |

## Optional Dependencies

### Superpowers Skills (Recommended)

The system references [Superpowers](https://github.com/github-copilot/superpowers) skills in several routes:

| Route | Superpowers Skills Used |
|-------|------------------------|
| `complex_feature` | brainstorming, writing-plans, test-driven-development |
| `bugfix` | systematic-debugging |
| `multi_agent` | subagent-driven-development, using-git-worktrees |

**Installation:**

```bash
# Clone superpowers to your Codex config
git clone https://github.com/github-copilot/superpowers ~/.codex/superpowers

# Create symlink for Qoder
mkdir -p ~/.qoder/skills
ln -s ~/.codex/superpowers/skills ~/.qoder/skills/superpowers

# Create symlink for Claude Code
mkdir -p ~/.claude/skills
ln -s ~/.codex/superpowers/skills ~/.claude/skills/superpowers
```

**Without Superpowers**: Routes will still function but may use alternative skills or simpler approaches.

### Context7 MCP Server (Recommended)

[Context7](https://github.com/upstash/context7-mcp) provides up-to-date documentation and code examples for libraries, SDKs, APIs, and frameworks. Used when work depends on specific versions or external APIs.

| Route | Context7 Usage |
|-------|----------------|
| `implementation` | API or version-sensitive work |
| `design_or_config` | Dependency/framework research |

**Installation:**

Add to your MCP configuration (e.g., `~/.qoder/SharedClientCache/mcp.json`):

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

**Get API Key**: Sign up at [Upstash Context7](https://context7.com) to get your API key.

**Without Context7**: Routes will use WebFetch/WebSearch for documentation lookup, which may be slower and less accurate for version-specific information.

## File Structure

```
config/
├── AGENTS.md                    # Core principles (~3.5KB)
├── workflow-index.yaml          # Route engine (10 routes)
├── layers/                      # 10 strategy layers
│   ├── methodology.yaml
│   ├── decision-alignment.yaml
│   ├── research-policy.yaml
│   ├── context-intake.yaml
│   ├── context-graph.yaml
│   ├── project-rules.yaml
│   ├── coding-quality.yaml
│   ├── collaboration.yaml
│   ├── runtime-continuity.yaml
│   └── prompting.yaml
├── skills-source/adapters/      # 9 adapter skills
│   ├── best-practice-research/
│   ├── code-review/
│   ├── codebase-impact/
│   ├── coding-workflow/
│   ├── critical-thinking/
│   ├── decision-alignment/
│   ├── implementation-quality/
│   ├── pr-workflow/
│   └── security-review/
├── evals/                       # Evaluation configs
├── templates/                   # 20 delivery templates
└── rules/                       # Route rules (Qoder-only)
```

## Research & Best Practices

This system synthesizes best practices from:

- **Anthropic** (2023-2024): Sycophancy research, tool-use patterns, context engineering
- **Sharma et al.** (2024): Reducing sycophancy via preference optimization
- **Claude Code Community**: Devil's advocate skills, critical thinking patterns
- **BMAD-METHOD**: Adversarial review, multi-agent patterns
- **Industry Consensus**: Progressive disclosure, decision-routing, quality gates

## Effectiveness Data

| Metric | Before | After | Source |
|--------|--------|-------|--------|
| Always-on context | 16KB+ | ~3.5KB | Token analysis |
| Sycophancy rate | 60-80% | 20-35% | Community experiments |
| Decision quality | Subjective | Structured tradeoffs | User feedback |
| Route accuracy | N/A | 85%+ correct | Eval suite |

## Contributing

Contributions welcome! Please read the architecture principles in `workflow-index.yaml` before proposing changes.

## License

MIT License. See [LICENSE](LICENSE) for details.
