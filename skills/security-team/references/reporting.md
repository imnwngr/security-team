# Report contract

Use Vietnamese unless the user requests otherwise. Each run has its own output directory. Avoid copying raw secrets into prompts or reports; retain file/line, secret type and a non-sensitive fingerprint only when needed.

## Required artifacts

- `project-profile.md`: target, source snapshot/dirty state, stack, attack surfaces, assumptions, environment and exclusions.
- `audit-plan.md`: mode, selected tasks/dependencies, evidence-based selection status for all eleven repos, upstream paths/revisions, integration mode, pending prerequisites/permissions.
- `coverage.json`: units with ID, scope, snapshot, method, task status (`planned`, `running`, `completed`, `partial`, `blocked`, `skipped`), checks performed, evidence paths and gaps. Completed means a scoped check completed, not that a unit is secure.
- `findings.json`: normalized records as specified below. Preserve raw upstream results separately.
- `REPORT.md`: executive result, prioritized confirmed issues, unresolved leads, hardening notes, coverage gaps, changes/tests, worker usage and pending approvals.

Survey-only mode needs just profile and plan; clearly state that no audit was executed. Runtime audit may add redacted logs or reproduction artifacts. No empty placeholder reports that imply a stage ran.

## Finding record

Each record includes:

| Field | Meaning |
|---|---|
| id, title | Stable identity and concrete issue |
| kind | vulnerability or hardening |
| status | candidate, confirmed, needs_validation, rejected, fixed_verified |
| severity | null until demonstrated impact supports a rating; never use confidence as severity |
| source_snapshot | Commit plus dirty-state evidence, or non-Git snapshot |
| locations | Paths, verified line numbers and symbols |
| root_cause, trust_boundary | Why the failure occurs and the boundary crossed |
| preconditions, source_to_sink | Attacker control, reachable path and defenses evaluated |
| impact | Concrete effect, with assumptions |
| evidence | Source traces, bounded observations and artifact references |
| provenance | Actual tool/method, version, task ID, native finding ID |
| verification | Verifier identity/method, independent true/false, checks and outcome |
| unresolved | Exact unknown facts; empty only when justified |
| remediation | Proposed scoped fix, or actual patch reference |
| regression_checks | What ran, exit/results, source snapshot; distinguish not-run |

Deduplicate matching root cause and boundary, preserving all affected locations and provenance. Do not merge distinct authorization and concurrency bugs just because they share a line. A rejected record retains refuting evidence. `fixed_verified` requires a patch and actual validation; a suggested fix is not a fixed vulnerability. Keep original finding evidence with its original snapshot.

## Final completion gate

Check that every selected task has a recorded outcome, all eleven selection decisions exist, confirmed findings have grounded evidence, tests are reported honestly and blockers remain visible. List missing dynamic validation separately from static review conclusions. Do not claim OWASP certification, complete security, or a clean pass merely because the finding count is zero. A coverage percentage requires an explicit denominator; otherwise report counts and scope descriptions.
