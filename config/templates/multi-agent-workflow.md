# Multi-Agent Workflow L2.6

This is an optional advanced workflow for complex tasks. Keep the global and project `AGENTS.md` files short; reference this file when parallelism would actually help.

## State Model

- `solo`: main thread is enough.
- `review_parallel`: main thread works while read-only review or risk analysis runs beside it.
- `implementation_parallel`: independent implementation slices can proceed in parallel.
- `integration`: stop expanding and consume existing outputs.
- `blocked_waiting`: main thread is blocked by test results, external data, or a needed investigation.

## Budget And Waves

Default active subagent budget is 3. Expand to 4-5 only when work is clearly independent, write surfaces do not overlap, and integration cost is justified.

Use waves:

1. Decide state.
2. Set budget.
3. Dispatch bounded tasks.
4. Collect results.
5. Integrate in the main thread.
6. Decide whether another wave is worth it.

## Roles

- `supervisor`: main thread; owns plan, critical path, integration, verification, and handoff.
- `delivery worker`: implements a bounded slice with clear file ownership.
- `review sidecar`: checks specs, boundaries, risks, and code quality.
- `verification sidecar`: tracks tests, regression risk, and validation gaps.
- `planner`: optional for large unclear decomposition.
- `researcher`: optional for external research or deep codebase discovery.

Do not turn every helper into a read-only explorer. If the slice is clear and independent, use a delivery worker.

## Consultation Contract

Use for read-only analysis, risk review, spec checks, or verification planning. Ask for:

- Conclusion
- Impacted files
- Recommended changes
- Tests or verification suggestions
- Unresolved risks
- Main-thread next action
- Whether to keep the sidecar

## Delivery Contract

Use for implementation, tests, docs, or config changes. Assign clear ownership and ask for:

- Files changed
- Goal completed
- Verification actually run
- Remaining issues
- How the main thread should integrate
- Whether the worker should continue, refresh, or retire

Workers are not alone in the codebase. They must not revert edits made by others and must adapt to concurrent changes.

## Lifecycle

- `active`: in use during the current wave.
- `dormant`: not in this wave, but likely useful later in the same stage.
- `retired`: no longer useful for this stage.
- `refresh-required`: role is still useful, but context is stale and should be rebuilt.

## Worktree Rule

- Read-only sidecars usually do not need worktrees.
- Short, local edits may use the main workspace if conflict risk is low.
- Longer-running or write-heavy parallel delivery workers should use git worktrees, separate branches, and explicit integration.

## Integration Rule

Before starting another implementation wave, consume sidecar and worker output. Record what was adopted, what was deferred, why, and what risks remain.

When the repository supports it, complete formal work through branch, PR, CI, review feedback, and follow-up fixes.
