# Current Sprint Template

> Documentation maintenance note:
> If this template is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/00_start_here.md` — update if sprint routing, sprint start, sprint closeout, or active-work routing changes.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update if template rules, sprint documentation rules, or folder/document responsibilities change.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if sprint document responsibilities, document flow, or template responsibilities change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — update if sprint workflow, closeout workflow, session workflow, documentation deferral, or idea parking changes.
> - `docs/sprints/current_sprint.md` — reset from this template at sprint closeout after sprint knowledge has been preserved.
>
> This file is the reusable template for `docs/sprints/current_sprint.md`. Do not use it as the active sprint document. Copy/reset from it when starting a new sprint.

---

# Current Sprint

## Sprint Identity

Sprint name:

- TODO

Release target:

- TODO

Branch:

- TODO

Sprint status:

- TODO

Start date:

- TODO

Target closeout date:

- TODO

Active hats likely needed:

- Project Manager
- Scrum Master / Sprint Operator
- Developer
- Documentation Architect
- QA / Tester

---

## Sprint Goal

TODO: Briefly describe the main goal of this sprint.

---

## Why This Sprint Matters

TODO: Explain why this sprint matters to the current release, project direction, or Developer Operating System.

---

## Source of Truth / Required Reading

Before working this sprint, review:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- Relevant `docs/systems/` docs
- Relevant `docs/game_flow/` docs

Sprint-specific docs:

- TODO

---

## In Scope

The following work is in scope for this sprint:

- TODO

---

## Out of Scope

The following work is not in scope for this sprint:

- TODO

If an out-of-scope idea appears, park it under:

- `Good Ideas / Not Current Scope`

or the correct planning document.

---

## Current Active Task

Use this section to keep the immediate task visible.

Active task:

- TODO

Current hat:

- TODO

Current file(s) or doc(s):

- TODO

Current blocker, if any:

- TODO

Next action:

- TODO

---

## Active Tasks

Tasks currently being worked on or approved for this sprint.

- [ ] TODO

---

## Completed This Sprint

Move completed tasks here instead of deleting them.

Completed tasks should later feed devlogs, milestones, release tracker, systems docs, game-flow docs, or planning docs during sprint closeout.

- [x] TODO completed example, remove when starting real sprint

---

## Decisions Made This Sprint

Record decisions made during this sprint.

Include enough context that future-you or an AI can understand why the decision was made.

Format:

- Decision:
  - Context:
  - Reason:
  - Affected docs:
  - Follow-up:

Decisions:

- TODO

---

## Blockers / Risks

Track anything blocking progress or creating risk.

Format:

- Blocker/Risk:
  - Source:
  - Impact:
  - Owner/Hat:
  - Next action:
  - Status:

Blockers / risks:

- TODO

---

## Good Ideas / Not Current Scope

Park useful ideas here when they should not derail the current sprint.

These should be reviewed during sprint closeout.

Format:

- Idea:
  - Source hat:
  - Why it is not current scope:
  - Review as:
  - Possible destination:

Ideas:

- TODO

---

## Developer OS Improvement Notes

Park workflow/system improvement ideas here when they should not derail the current sprint.

Review later while wearing Development Systems Architect Hat.

Before adding a new item, check this section to avoid duplicates.

Format:

- Improvement idea:
  - Source hat:
  - Friction / reason:
  - Suggested fix:
  - Review as:
  - Possible affected docs:

Improvement notes:

- TODO

---

## Documentation TODO / Deferred Updates

Use this section when docs should be updated later instead of interrupting active work.

Format:

- Documentation TODO:
  - Reason:
  - Affected docs:
  - Source hat:
  - Review as:
  - Status:

TODOs:

- TODO

---

## Session Logs / Work Notes

Use this section for short session logs, Stand-Down Updates, or work summaries when a separate devlog is not needed yet.

Long or historically important work should become a devlog under `docs/01_devlogs/`.

Format:

- Date:
  - Active hat:
  - Goal:
  - Completed:
  - Decisions:
  - Blockers:
  - Ideas parked:
  - Documentation TODOs:
  - Validation notes:
  - Next step:
  - Save destination:

When the user asks for a Stand-Down Update or session log, the AI should include an exact paste destination or terminal append command when the update should be saved.

Session logs:

- TODO

---

## QA / Validation Notes

Use this section to track testing, validation, devices, regressions, AI behavior validation, and pass/fail results.

Format:

- Test:
  - Environment:
  - Expected:
  - Actual:
  - Result:
    - Pass / Partial pass / Fail
  - Correction needed:
  - Affected docs:
  - Retest needed:
  - Follow-up:

AI behavior validation notes should be parked here during test batches before Development Systems Architect review converts findings into workflow rules.

Validation notes:

- TODO

---

## Git / Integration Notes

Use this section to track branch, commit, merge, push, or repo safety notes.

Format:

- Git note:
  - Branch:
  - Status:
  - Commit(s):
  - Push status:
  - Follow-up:

Git notes:

- TODO

---

## Files / Docs Changed This Sprint

Track important files and docs touched during this sprint.

This does not need to include every tiny file, but should capture important changed systems/docs.

Code / scene / asset files:

- TODO

Documentation files:

- TODO

---

## Sprint Closeout Checklist

Do not reset this sprint until this checklist is complete or explicitly deferred.

### Review Sprint Contents

- [ ] Review Sprint Goal.
- [ ] Review In Scope / Out of Scope.
- [ ] Review Active Tasks.
- [ ] Review Completed This Sprint.
- [ ] Review Decisions Made This Sprint.
- [ ] Review Blockers / Risks.
- [ ] Review Good Ideas / Not Current Scope.
- [ ] Review Developer OS Improvement Notes.
- [ ] Review Documentation TODO / Deferred Updates.
- [ ] Review Session Logs / Work Notes.
- [ ] Review QA / Validation Notes.
- [ ] Review Git / Integration Notes.

### Preserve Completed Work

- [ ] Move completed work into `docs/01_devlogs/` if historically useful.
- [ ] Update `docs/01_devlogs/project_milestones.md` if a milestone was reached.
- [ ] Update `docs/release_tracker/pre_alpha_0_1.md` if release readiness changed.
- [ ] Update related `docs/systems/` docs if system behavior changed.
- [ ] Update related `docs/game_flow/` docs if player flow changed.
- [ ] Move future ideas into `docs/planning/` if they survived review.
- [ ] Preserve unresolved documentation TODOs.
- [ ] Preserve unresolved Developer OS improvement notes.
- [ ] Preserve unresolved blockers or carry them forward.

### Prepare Next Sprint

- [ ] Decide what unfinished work moves to the next sprint.
- [ ] Decide what planned work should be deferred.
- [ ] Decide next sprint name.
- [ ] Decide next sprint branch.
- [ ] Decide next sprint goal.
- [ ] Decide next sprint in-scope / out-of-scope boundaries.
- [ ] Reset `docs/sprints/current_sprint.md` from this template.
- [ ] Fill in the new sprint identity.
- [ ] Fill in the new sprint goal.
- [ ] Fill in initial active tasks.
- [ ] Commit sprint closeout and reset changes.

---

## Next Sprint Candidate Tasks

Tasks that may become the next sprint focus.

These are not automatically accepted into the next sprint.

- TODO

---

## Sprint Closeout / Archive Notes

Use this section during closeout to note where sprint knowledge was moved.

Format:

- Closeout note:
  - Moved to:
  - Reason:
  - Follow-up:

Archive notes:

- TODO

---

# Template Use Rule

This file is a template.

Do not treat it as the active sprint.

At sprint closeout:

1. Preserve completed sprint knowledge.
2. Move or carry forward unresolved work.
3. Copy this template into `docs/sprints/current_sprint.md`.
4. Replace TODO placeholders with the next sprint's real information.
5. Commit the sprint reset.

Never reset `docs/sprints/current_sprint.md` from memory once this template exists.
---

# Minimal Developer Documentation Loop Note

During active development, use this sprint doc as the fast backup target.

The AI may temporarily track findings in session memory, then append one clean checkpoint block here using:

```bash
tools/docs/append_to_sprint.sh "Heading" <<'EOF'
Body text
EOF
```

Do not over-polish this file during active coding.

Cleanup, reorganization, and durable rule updates should happen during a later Documentation Architect / Development Systems Architect pass.

