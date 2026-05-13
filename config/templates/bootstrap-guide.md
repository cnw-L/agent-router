# Target-State Project Bootstrap Guide

Use this guide when initializing or standardizing a long-lived project.

## Minimal Setup

Create only the files that are useful for the project:

- `AGENTS.md`
- `docs/ts-handoff.md` when work will span sessions or needs continuity
- `docs/context-manifest.md` when code context spans multiple files or repeated rereads would be costly
- `docs/ts-devlog.md` when decisions, rejected paths, or stage notes should be human-readable

Do not add project context files for trivial one-off scripts unless the user asks.

## Composite L3 Runtime Setup

Add `docs/ts-runtime/` only when the project benefits from metadata-first context, resumable task state, or path-specific rules.

Recommended files:

- `docs/ts-runtime/project-rules.yaml`: path, glob, language, module, role, and task-specific rule metadata
- `docs/ts-runtime/task-state.yaml`: compact resumable state for complex active work

Use `project-rules.yaml` when `AGENTS.md` is getting too large or rules should activate only for matching files/tasks. Use `task-state.yaml` only for complex resumable work; it is not a durable runtime or execution engine.

## Optional Structured Context

Add these only when the project has outgrown the minimal setup:

- `docs/specs/` for stable architecture, domain, API, product, or security rules
- `docs/tasks/` for multiple active delivery tracks or task-specific PRDs/context
- `docs/workspace/<name>/journal.md` for personal continuity and stage notes
- `docs/ts-checkpoints/` for complex pause/resume, multi-agent integration, or risky refactor snapshots

## Optional Quality And Security Layer

For long-lived or team projects, consider adding:

- `docs/ts-tooling.md`
- `scripts/ts_checks.ps1`
- `.semgrepignore`
- `.gitleaks.toml`
- `trivy.yaml`

Use existing project tools first. Do not add scanners just to make the workflow look complete.

## Bootstrap Steps

1. Inspect repository structure, stack, existing docs, and test commands.
2. Read any existing `AGENTS.md`, `CLAUDE.md`, `.cursor/rules`, `.github/copilot-instructions.md`, or project instruction files.
3. Create or merge the minimal useful context files.
4. Add `docs/ts-runtime/project-rules.yaml` only when path/task metadata will reduce always-on instruction size.
5. Add `docs/ts-runtime/task-state.yaml` only for complex active work that needs resume state.
6. Record real commands and real architecture boundaries, not generic boilerplate.
7. Keep `AGENTS.md` short; move details to `docs/specs/`, `docs/tasks/`, `docs/ts-runtime/`, or tooling docs.
8. Run a lightweight verification command if available.

## Default File Split

- `AGENTS.md`: stable project-wide rules and commands
- `docs/ts-runtime/project-rules.yaml`: path/task/role rule activation metadata
- `docs/ts-runtime/task-state.yaml`: compact state for complex active tasks
- `docs/ts-handoff.md`: current task recovery
- `docs/context-manifest.md`: minimal reusable code context slice
- `docs/ts-devlog.md`: concise development diary
- `docs/ts-checkpoints/`: explicit recovery snapshots for complex boundaries
- `docs/specs/`: stable specifications
- `docs/tasks/`: task-specific context and status
- `docs/workspace/`: continuity notes and journals

## Avoid

- Do not create all runtime files for tiny projects by default.
- Do not duplicate Superpowers methodology in project rules.
- Do not turn `project-rules.yaml` into a second `AGENTS.md`.
- Do not use task state as a substitute for tests, commits, or handoff notes.