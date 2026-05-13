---
name: route-review
trigger: pattern
pattern: "review|audit|PR review|self.?review|risk check"
---

# Route: review

**When:** review, audit, PR review, self-review, or risk check
**Mode:** independent_review
**Load:** coding_quality, collaboration layers
**Skills:** code-review
**Gate:** findings_first

## Policy

Report findings first, ordered by severity. Focus on real bugs, regressions, security/privacy risks, broken contracts, missing tests, unnecessary complexity, duplicate logic, and target-state violations. If no issues are found, say so and mention remaining verification gaps.