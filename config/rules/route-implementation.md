---
name: route-implementation
trigger: pattern
pattern: "plan.*confirmed|implement|code must change|target.?state"
---

# Route: implementation

**When:** plan is confirmed and code must change
**Mode:** target_state_build
**Load:** context_intake, project_rules, coding_quality layers
**Skills:** codebase-impact, implementation-quality, coding-workflow
**Tools:** Context7 if API or version-sensitive
**Gate:** relevant_tests_lint_type_build

**Confirmation**: This route only triggers after explicit user confirmation. If user is still discussing or exploring, stay in analysis mode (see AGENTS.md Discussion vs Execution Mode).

## Implementation Notes

- Follow context-intake layer for map → slice → expand → impact_set → delta_review flow
- Follow coding-quality layer for implementation modes, code rules, and discipline checklist
- Research before implementation: project-local patterns, related tests, Context7 for API facts
- Stop and reassess when: >5 files for narrow request, new dependency needed, or new framework introduced