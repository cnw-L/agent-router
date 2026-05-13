---
name: route-continuity
trigger: pattern
pattern: "long.?running|multi.?session|multi.?agent|failed verification|resume|new thread"
---

# Route: continuity

**When:** long-running, multi-session, multi-agent, major decision, failed verification to resume, or user asks for new thread
**Mode:** lightweight_state
**Load:** runtime_continuity layer
**Gate:** concise_artifact_only_if_reduces_future_cost

## Artifacts Selection

- tiny_task: none
- normal_code_task: handoff (if project uses it)
- complex_code_task: context_manifest, handoff, devlog (if decisions matter)
- multi_session/multi_agent: context_manifest, task_state, handoff, checkpoint

## Principles

Write continuity artifacts only when they reduce future rereading or recovery cost. Keep artifacts concise, factual, project-local. Do not create for tiny tasks unless asked.

## Available Artifacts

- `docs/ts-handoff.md` - current goal, status, files changed, decisions, tests, risks, next steps, assumptions
- `docs/context-manifest.md` - multi-file context, impact set, contracts to preserve
- `docs/ts-devlog.md` - important decisions, rejected paths, complex investigations
- `docs/ts-runtime/task-state.yaml` - compact state for complex active tasks
- `docs/ts-checkpoints/` - risky pause/resume or multi-agent integration boundaries