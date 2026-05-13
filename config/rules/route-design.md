---
name: route-design
trigger: pattern
pattern: "architecture|configuration|workflow|policy|dependency|best.?practice decision"
---

# Route: design_or_config

**When:** architecture, configuration, workflow, policy, dependency, or best-practice decision
**Mode:** decision_first
**Load:** decision_alignment layer, research_policy layer
**Skills:** decision-alignment, best-practice-research
**Output:** goal, constraints, options, tradeoffs, recommendation, acceptance_criteria
**Gate:** user_confirmation_before_write

## Rules

- State assumptions explicitly.
- Separate facts from inferences.
- Prefer official docs and maintained projects for evidence.
- Ask for confirmation before semantic config or architecture changes.
- Do not continue researching once a decision-quality recommendation is clear.

## Decision Alignment Output Contract

- goal_understanding
- known_facts
- constraints
- options
- tradeoffs
- recommendation
- rejected_options_with_reasons
- acceptance_criteria
- confirmation_points

## Research Before Decision

- Sources prefer: official documentation, maintained GitHub repositories, mature project examples, benchmark/eval reports, security guidance
- Output: consensus, disagreements, applicable pattern, non-applicable pattern, recommendation