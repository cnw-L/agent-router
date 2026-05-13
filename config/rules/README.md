# Route Rules (Qoder Platform)

This directory contains pattern-matching route rules for the Qoder platform.

## Purpose

Route rules operationalize the workflow-index.yaml routes with automatic pattern detection. When a user message matches a rule pattern, the corresponding route is triggered.

## Format

Each rule file follows this format:

```markdown
---
name: route-[route-name]
trigger: pattern
pattern: "[regex or keyword pattern]"
---

# Route: [route-name]

**When:** [condition description]
**Mode:** [execution mode]
**Load:** [layers to load]
**Skills:** [skills to activate]
**Gate:** [verification gate]

## Implementation Notes

[Brief notes about this route]
```

## Platform Compatibility

- **Qoder**: Rules are automatically loaded from `~/.qoder/rules/`
- **Claude Code**: Rules are not supported; routing relies on AGENTS.md guidance
- **Codex**: Rules are not supported; routing relies on workflow-index.yaml parsing

## Creating Custom Rules

To create a new route rule:

1. Copy the template below
2. Replace placeholders with your route configuration
3. Save as `route-[name].md` in this directory

## Rule Template

```markdown
---
name: route-[name]
trigger: pattern
pattern: "[trigger pattern]"
---

# Route: [name]

**When:** [when condition from workflow-index.yaml]
**Mode:** [mode from workflow-index.yaml]
**Load:** [layers from workflow-index.yaml]
**Skills:** [skills from workflow-index.yaml]
**Gate:** [gate from workflow-index.yaml]
```

## Notes

Rules are optional. If the Qoder platform is used without rules, routing will still work based on AGENTS.md guidance, but will not have automatic pattern detection.