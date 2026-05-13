---
name: route-pr
trigger: pattern
pattern: "branch|commit|pull request|PR|CI|GitHub Actions|release|review.?comment"
---

# Route: pr_or_ci

**When:** branch, PR, CI, GitHub Actions, review comments, or release loop
**Mode:** pr_ci_loop
**Skills:** pr-workflow
**Tools:** GitHub if available
**Gate:** ci_or_local_equivalent

## Process

1. Confirm branch and diff scope
2. Read relevant issue/PR/CI/review context
3. Keep changes scoped and reviewable
4. Run focused checks before full checks
5. Address review comments with evidence, not blind agreement
6. Summarize changes, verification, and remaining risk