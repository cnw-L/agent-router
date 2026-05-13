---
name: route-multi-agent
trigger: pattern
pattern: "independent.*exploration|sidecar|slow verification|disjoint.*write|parallel"
---

# Route: multi_agent

**When:** independent read-only exploration, sidecar review, slow verification, or disjoint write slices
**Mode:** bounded_parallelism
**Load:** collaboration layer
**Prefer:** superpowers:subagent-driven-development, superpowers:using-git-worktrees
**Gate:** integrate_outputs_before_next_wave

## Budgets

Default 2 active subagents, max 4. Expand to 4-5 only when work is clearly independent, write surfaces do not overlap, and integration cost is justified.

## Roles

- supervisor (me): plan, dispatch, integrate, verify, decide, report
- context_explorer (read-only): find smallest useful context without full-repo reads
- delivery_worker (bounded_write): implement a bounded slice with clear file ownership
- review_sidecar (read-only): check specs, boundaries, risks, code quality
- verification_sidecar (read-only): run or inspect verification surface, return evidence
- security_sidecar (read-only): review security, privacy, trust-boundary risks

## Lifecycle

active -> dormant -> retired -> refresh-required

## Rule

Before starting another wave, consume all existing sidecar and worker output. Record what was adopted, deferred, and residual risks.