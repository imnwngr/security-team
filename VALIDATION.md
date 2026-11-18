# Validation record

## Twelve-repository catalog — 2026-11-18

- `scripts/Test-Package.ps1` passed on PowerShell 7.5.4. It checked the skill frontmatter and invocation, 28 local Markdown links, 6 HTML links/assets, both SVGs, PowerShell syntax and matching repository identities across the catalog, both READMEs, prerequisites and an offline downloader manifest. In an isolated copy, removing Claude Kit from the downloader or replacing its URL in the Vietnamese table caused the expected failures.
- Both SVGs were rendered and inspected. The source selector and the hero display the current count without clipping.
- In a temporary destination the installer preview wrote nothing. The installed skill matched the source file-for-file by SHA-256, including the Claude Kit reference, and the installer refused an overwrite.
- The downloader preview wrote nothing. An upgrade fixture containing the previous catalog directories fetched only `yeswehack/claude-kit`. Its recorded commit matched the checkout at `3928c3475bae5211835d05190d17fa1c445dd6f7`. Existing marker files survived. A repeat run wrote a separate manifest with 12 `existing_unverified` records and preserved the original manifest. A simulated clone failure produced a failed record, preserved later entries and returned an error.
- Reviewed all 15 [behavioral scenarios](validation-scenarios.md) against the coordinator instructions. In a same-agent walkthrough, a same-tenant trace left a draft’s cross-tenant claim unsupported. The write-up of a confirmed export issue cited the supplied redacted artifact. Missing program rules withheld submission readiness. Routine synthesis skipped Claude Kit. These were review decisions on fixtures, without a live target or independent reviewer.
- A YAML parser validated both the skill frontmatter and invocation metadata. The optional external `quick_validate.py` could not start because the available Python runtime lacks PyYAML. Windows PowerShell 5.1 parsed all three scripts successfully. Its local execution policy blocked running the suite on that host.
- `git diff --check` passed. Live scanner interoperability across the catalog remains untested.

## README and visual assets — 2026-10-28

- Updated the primary README to English, retained the Vietnamese guide, and added original SVG banner/pipeline artwork to both language versions.
- Added the missing upstream prerequisites guide and checked internal README/documentation links.
- Updated the structural checker to cover HTML `img src` and `a href` targets as well as Markdown links, and to parse both SVG assets as XML.
- Executed `scripts/Test-Package.ps1`: **PASS** — 19 Markdown links, 6 HTML assets/links, 2 valid SVG documents, the catalog at that revision, PowerShell syntax and invocation metadata.
- `git diff --check` passed. The first headless Edge rendering attempt failed with access-denied errors in its local process/cache sandbox. A subsequent approved elevated run rendered both SVGs successfully. The generated hero and pipeline preview PNGs were visually inspected for readability and layout; the actual GitHub README rendering has not been checked.
- Live upstream integration was untested at this revision.

## Initial package checks — 2026-10-27

- Passed `scripts/Test-Package.ps1`: required SKILL frontmatter, six local reference links, the initial catalog, PowerShell script syntax, and default prompt referencing `$security-team`.
- Installer tested in a temporary workspace: every copied file matched its source hash, an existing destination was rejected, and `-WhatIf` wrote no files.
- Toolkit downloader tested with `-WhatIf` (no writes/network) and existing fixture directories for the initial catalog. It preserved the directories and recorded each as `existing_unverified`. Actual network cloning and partial network-failure recovery were not exercised.
- Reviewed instructions for survey versus execution, unavailable tools, scoped delegation, duplicate findings, source drift, and upstream auto-commit conflicts. This was author review, not independent agent testing.
- The bundled `skill-creator` Python validator was attempted but could not run: the available Python command resolves to a Windows app alias without a working interpreter. No dependency was installed to bypass this limitation.
- No live audit, scanner execution, real user skill installation, cloud connection, hook activation or end-to-end toolkit integration test was performed. The installer test only copied into an isolated temporary workspace.
- `validation-scenarios.md` contains future behavioral acceptance cases; those cases have not been executed by an independent agent.

The package is a usable instruction-based skill for project-specific planning and permitted audit work. Executable compatibility must be established per selected upstream and host during the first pilot.
