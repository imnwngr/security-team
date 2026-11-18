# Claude Kit on Codex

Select YesWeHack Claude Kit for a question about an existing finding, its evidence or a report draft. Reuse the source traces and observations from Cloudflare or the other selected specialists. Codex retains the finding ledger and the final report. For a routine audit with no such question, record the reason to skip Claude Kit.

## Choose the smallest applicable review

| Input and question | Read in the upstream checkout | Return to the coordinator |
|---|---|---|
| A confirmed finding needs a write-up | `skills/write/SKILL.md` | Draft the description, discovery, supporting evidence, observed behavior and impact from the supplied notes. Keep platform fields such as asset and severity separate from the body. Include a specific remedy or reference only if it helps the recipient. Identify any missing fact for the author. |
| An existing draft needs pre-submission triage | `skills/triage/SKILL.md` and `skills/triage/references/ai-slop.md` | Check program scope and exclusions, then flag invented details, unsupported impact, incomplete evidence and wording that hides the uncertainty. Give a draft verdict and prioritized corrections with pointers to the supplied material. If the draft or program rules are missing, request the missing input and withhold the submission verdict. Internal report reviews use the agreed project scope. |
| A specific vulnerability class or impact claim is disputed | The matching section of `skills/gotchas/SKILL.md`, also usable during triage | Compare the claim with the minimum evidence for that class and plausible benign explanations. For example, two successful responses alone do not establish a duplicate credit. Cite the observed state or record that it is missing. For an unlisted class, use the ordinary evidence contract. |

During triage, consult the matching `gotchas` section when the draft names a covered class. The upstream draft verdicts are `READY TO SUBMIT`, `NEEDS FIXES` and `DO NOT SUBMIT`. Record the verdict in the draft review only. An out-of-program asset can have a confirmed internal finding. Submission remains the author’s decision.

## Apply the rules to this task

When the role is selected, read `always-on-rules.md` explicitly. Check the asset, class exclusions and severity cap against the supplied rules. Tie claims about impact and scoring to verified conditions. Keep the author’s observations, redact sensitive material and describe missing evidence plainly. The review uses the artifacts already in scope. A missing observation stays open and grants no permission to contact a target or gather more data.

Offer wording the author can defend and omit generic vulnerability descriptions. Check whether a reader can follow the submitted evidence from its stated preconditions. Flag any supplied evidence gathered outside the agreed scope or through prohibited methods when assessing submission readiness.

Record the checkout revision, selected file or section, finding ID and evidence references. Preserve the original verifier and record Codex as the draft reviewer. If the needed guidance is unavailable, label any fallback as Codex manual review. Follow the existing [report contract](reporting.md).

## Upstream and license

Reviewed revision `3928c3475bae5211835d05190d17fa1c445dd6f7`. The plugin metadata and README specify **GPL-3.0-or-later**. The downloader provides a separate source checkout with its license. This package contains original routing notes and links. Check the revision in use before relying on a procedure. [Upstream tree](https://github.com/yeswehack/claude-kit/tree/3928c3475bae5211835d05190d17fa1c445dd6f7) · [Plugin metadata](https://github.com/yeswehack/claude-kit/blob/3928c3475bae5211835d05190d17fa1c445dd6f7/.claude-plugin/plugin.json) · [License](https://github.com/yeswehack/claude-kit/blob/3928c3475bae5211835d05190d17fa1c445dd6f7/LICENSE)

Claude Code loads the rule file through a `SessionStart` hook. Codex uses the Markdown as reference material only for the selected task. The integration requires neither plugin installation nor slash commands, hook execution or global rule injection. [Upstream hook declaration](https://github.com/yeswehack/claude-kit/blob/3928c3475bae5211835d05190d17fa1c445dd6f7/hooks/hooks.json)
