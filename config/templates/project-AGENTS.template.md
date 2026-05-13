# Project Assistant Instructions

## Project Overview

- Purpose:
- Primary stack:
- Package manager:
- Runtime versions:
- Important entry points:

## Repository Structure

- `src/`:
- `tests/`:
- `docs/`:
- `scripts/`:
- Generated/vendor paths to avoid:

## Common Commands

- Install:
- Run locally:
- Focused test:
- Full test:
- Lint:
- Type check:
- Format check:
- Build:
- Docs check:
- Quick check: `scripts/ts_checks.ps1`

## Gate Model

- Iteration gate:
- Completion gate:
- Landing gate:
- CI gate:

## Change-Surface Verification Matrix

| Change Surface | Required Checks |
|---|---|
| Runtime code |  |
| Tests |  |
| Public API / SDK |  |
| Frontend UI |  |
| Docs only |  |
| Build/config/CI |  |
| Security/auth/secrets/filesystem/network |  |
| Generated files |  |

## Architecture Boundaries

- 

## Path-Specific Instructions

Read more specific `AGENTS.md` files when working under their subtree:

- `frontend/AGENTS.md`:
- `backend/AGENTS.md`:
- `tests/AGENTS.md`:
- `docs/AGENTS.md`:

## Development Rules

- Follow existing project patterns before adding abstractions.
- Keep changes small and reviewable.
- Do not rewrite unrelated code or revert user changes.
- Do not hand-edit generated files unless this project explicitly allows it.
- Update tests, docs, examples, or changelog entries when behavior changes.

## Git Safety

- Check status/diff before staging or committing.
- Prefer staging specific files.
- Do not push, amend, rebase, reset hard, clean, or force-push unless explicitly asked.

## Done When

- The requested behavior is implemented.
- Relevant gate checks have been run and results recorded.
- Known failures are explained as related or unrelated.
- Handoff is updated only if work spans sessions, verification failed and must continue later, or a major decision was made.

## Project Rules

Use `docs/ts-runtime/project-rules.yaml` when path, language, module, or task-specific rules would keep `AGENTS.md` too large. Keep this file for stable project-wide rules only.

## Context Continuity

- Use `docs/context-manifest.md` for reusable code maps on unfamiliar, multi-file, or public-contract work.
- Use `docs/ts-handoff.md` for current task recovery.
- Use `docs/ts-devlog.md` for meaningful decisions or rejected paths.
- Use docs/ts-runtime/task-state.yaml only for complex active work that needs compact resume state.
- Use docs/ts-checkpoints/ only for risky pause/resume or multi-agent integration boundaries.