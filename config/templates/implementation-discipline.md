# Implementation Discipline Gate

Prefer the smallest correct change. Stop expanding context once the impact set is clear enough to act safely.

If 10 clear lines solve it, do not write 20. Add files, abstractions, dependencies, configuration, or generalized machinery only when required by the task, when they remove real complexity, or when they match an existing project pattern.

## Prompt Discipline

- Do not ask for or expose full hidden reasoning; report brief plans, decisions, evidence, risks, and verification.
- Prefer evidence-driven context expansion over reading the whole repository.
- Keep implementation prompts specific to the task, files, constraints, and checks.

## Checklist

- Did this change touch the fewest reasonable files?
- Did it avoid unrelated refactors and formatting churn?
- Did it reuse existing helpers, patterns, and project conventions?
- Did it avoid unnecessary abstractions or premature generalization?
- Did it avoid unnecessary dependencies?
- Is the verification focused and relevant?
- If more than 5 files changed, is the blast radius justified?
- If a file or function grew significantly, is the extra complexity necessary?

## Stop And Reassess

Pause and explain the trade-off before continuing when:

- The implementation needs more than 5 files for a narrow request.
- A new dependency seems necessary.
- A new framework, service, or cross-cutting abstraction is being introduced.
- The fix cannot be verified with the available project checks.

