# Target-State Tooling

Use this file in a project only when a shared quality or security entry point is useful.

## Preferred Order

Use the repository's existing tools first:

- tests
- lint
- type checks
- build
- formatting checks
- CI commands documented by the project

## Optional Tools

- `ruff`: fast Python lint/format feedback
- `semgrep`: rule-based code scanning
- `gitleaks`: secret detection
- `trivy`: filesystem, dependency, and infrastructure scanning

## Local Gate

Document the exact commands for this repository here. Avoid generic commands that are not installed or not relevant.

- Quick check:
- Full check:
- Security check: