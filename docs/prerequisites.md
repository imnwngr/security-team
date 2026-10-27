# Toolkit prerequisites and readiness

Security Team is a Codex skill and an eleven-repository **routing catalog**. The coordinator can assess a project with Git, PowerShell and Codex access. Downloading toolkit sources does not activate upstream scanners, install dependencies, or enable hooks.

Use the [routing catalog](../skills/security-team/references/catalog.md) to select relevant upstreams before installing anything. Check each repository's README, lockfiles, release notes, license and host support at the **checked-out commit**. Upstream requirements may change.

## Readiness levels

| Level | Evidence needed | What can be claimed |
|---|---|---|
| **Source available** | Local checkout and recorded commit | Documentation and code may be reviewed. |
| **Procedure available** | Applicable instructions can be read in the current agent | Codex can apply the methodology where compatible. |
| **Executable ready** | Dependencies, host integration, permissions and scoped target checked | That tool can be attempted. |
| **Verified run** | Actual command, exit status, source revision and output retained | Results can be reported as evidence, subject to review. |

Do not equate source availability or methodology-only use with a verified scanner run.

## Upstream setup checklist

| Source | Verify before activation |
|---|---|
| [CC Safety Net](https://github.com/kenryu42/cc-safety-net) | Supported agent, Node.js requirements and hook changes. Protects agent actions; does not scan the application. |
| [AgentGuard](https://github.com/GoPlusSecurity/agentguard) | Install method, local/cloud modes and optional hooks; review the guard itself. |
| [OWASP Security Skill](https://github.com/agamm/claude-code-owasp) | Relevant framework controls and references; reading guidance does not require a scanner. |
| [vbsec](https://github.com/tanviet12/vbsec) | Supported language/framework and agent; mark guidance-only use clearly. |
| [Ghost Security](https://github.com/ghostsecurity/skills) | The selected secrets, dependency, code or dynamic module; binaries, connectivity and test target. |
| [Cloudflare Security Audit](https://github.com/cloudflare/security-audit-skill) | Entry point, validators, execution isolation and source-coverage contract. |
| [Trail of Bits Skills](https://github.com/trailofbits/skills) | Relevant subskills and any required external tool such as CodeQL, Semgrep or fuzzers. |
| [PYA](https://github.com/AgriciDaniel/pya) | Claude Code plugin compatibility; distinguish reading its methodology from running its native integration. |
| [Bug Hunter](https://github.com/codexstar69/bug-hunter) | Install for the actual host; preserve scan-only defaults unless fixing is requested. |
| [Anthropic Reference Harness](https://github.com/anthropics/defending-code-reference-harness) | Maintenance status, native-code applicability, Docker/isolation, Python and API prerequisites. |
| [ptn1411 Skills](https://github.com/ptn1411/skill) | A concrete subskill, Python requirements and artifact-specific tools. |

## Recommended sequence

1. Validate and install Security Team at user scope **or** project scope.
2. Clone upstream source with the toolkit helper and inspect the revision manifest.
3. Ask Security Team for a survey; it selects applicable tools and lists missing prerequisites.
4. Review changes, network access and runtime permissions for the selected checks.
5. Run authorized checks, retain evidence, verify candidate findings and report coverage gaps.

Independent read-only checks may run in parallel when they use the same source snapshot and do not interfere. Sequence dependent work: select before execution, collect evidence before verification, verify before reporting.

## Download only

From the Security Team checkout:

```powershell
& .\scripts\Test-Package.ps1
& .\scripts\Get-Toolkit.ps1 -WhatIf
& .\scripts\Get-Toolkit.ps1 -Destination 'D:\Security-Toolkit'
```

The helper clones ordinary Git history and submodules. Git LFS objects, release binaries, models, service accounts and dependencies may need separate upstream instructions. Existing checkout directories are preserved; the helper does not automatically update or repair them.
