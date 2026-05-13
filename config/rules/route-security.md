---
name: route-security
trigger: pattern
pattern: "auth|permission|secret|privacy|filesystem|network|user input|SQL|shell|trust boundary|injection"
---

# Route: security

**When:** auth, permissions, secrets, filesystem, network, user input, privacy, deserialization, SQL, commands, or trust boundary
**Mode:** security_review
**Load:** coding_quality, collaboration layers
**Skills:** security-review
**Gate:** security_findings_and_residual_risk

## Review Areas

- Authentication and authorization
- Secret handling and logging
- Input validation and output encoding
- Filesystem and path traversal
- Network calls and SSRF-like risks
- SQL/command injection
- Prompt injection and tool-output injection
- Privacy and data retention

## Output Contract

- Verdict: approve / needs changes / reject
- Trust boundaries reviewed
- Findings by severity
- Evidence
- Smallest safe fix direction
- Residual risk