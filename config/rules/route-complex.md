---
name: route-complex
trigger: pattern
pattern: "new feature|cross.?module|public API|multi.?file product change"
---

# Route: complex_feature

**When:** new feature, cross-module behavior, public API, or multi-file product change
**Mode:** spec_then_target_state
**Load:** decision_alignment, research_policy, context_intake, coding_quality layers
**Skills:** decision-alignment, codebase-impact, implementation-quality
**Prefer:** superpowers:brainstorming, superpowers:writing-plans, superpowers:test-driven-development
**Gate:** focused_tests_plus_review

**Flow**: decision-alignment → best-practice-research → codebase-impact → implementation-quality → tests + review

**Confirmation**: Present options, tradeoffs, and recommendation first. Do NOT implement until user explicitly confirms the plan (see AGENTS.md Discussion vs Execution Mode).

## Flow

1. Use decision-alignment to align on goals and tradeoffs
2. Use best-practice-research for evidence gathering
3. Use codebase-impact to build bounded impact set
4. Use implementation-quality for target-state implementation
5. Run focused tests and review before completion