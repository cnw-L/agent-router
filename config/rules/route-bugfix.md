---
name: route-bugfix
trigger: pattern
pattern: "bug|failing test|regression|crash|flaky|unexpected output"
---

# Route: bugfix

**When:** bug, failing test, regression, crash, flaky behavior, or unexpected output
**Mode:** diagnose_then_target_state_fix
**Load:** context_intake, coding_quality layers
**Skills:** codebase-impact, implementation-quality
**Prefer:** superpowers:systematic-debugging
**Gate:** regression_test_plus_verification

**Flow**: reproduce → identify impact → find root cause → propose fix → confirm → implement

**Confirmation**: Present diagnosis and proposed fix BEFORE implementing. Wait for user confirmation (see AGENTS.md Discussion vs Execution Mode).

## Flow

1. Reproduce the issue
2. Use codebase-impact to identify the blast radius
3. Use superpowers:systematic-debugging to find root cause
4. Use implementation-quality for target-state fix
5. Run regression test plus verification