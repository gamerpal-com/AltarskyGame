# Development Workflow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/00_start_here.md` — update if top-level routing, hat onboarding, hat switching, AI first-response behavior, session closeout, sprint closeout, or workflow routing changes.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update if workflow changes require documentation rule changes, folder purpose changes, maintenance-note changes, template rule changes, or new document categories.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if document responsibilities, project-state routing, document flow, hat-to-document routing, or active document relationships change.
> - `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md` — update while this Developer Operating System is still being designed or if a major workflow idea is not yet ready for final integration.
> - `docs/00_ReadMeFirst/templates/current_sprint_template.md` — update after it is created if sprint structure, sprint reset behavior, closeout checklist, active/completed task sections, deferred idea sections, or documentation TODO sections change.
> - `docs/sprints/current_sprint.md` — update if this workflow changes active sprint behavior, current tasks, completed task tracking, deferred ideas, documentation TODOs, session logs, or sprint closeout.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if workflow changes affect Pre-Alpha 0.1 completion criteria, release readiness, or required documentation infrastructure.
>
> This document defines how AltarSky work happens. It is the role-aware workflow brain of the AltarSky Developer Operating System.

---

# Purpose

This document explains how to work on AltarSky.

It defines:

- Hats / work modes
- Hat onboarding
- Hat switching
- Hat handoffs
- Session workflow
- Sprint workflow
- Idea capture
- Blowout mitigation
- Documentation deferral
- Session logs
- Sprint closeout
- Git hygiene
- AI guidance
- System evolution

Use this document after `docs/00_ReadMeFirst/00_start_here.md` routes you here.

If you need documentation rules or folder purposes, read:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

If you need to understand what docs exist and what feeds into what, read:

- `docs/00_ReadMeFirst/02_project_document_map.md`

If this workflow becomes confusing or incomplete, capture an improvement note and review it later while wearing Development Systems Architect Hat.

---

# Core Workflow Rule

Do not treat every AltarSky session as a coding session.

Every session should begin by identifying:

1. Why the user is here.
2. What hat or work mode is active.
3. Whether the user is switching from another hat.
4. What documents are source of truth for this task.
5. What should be updated, checked, or parked before and after the task.

The goal is to work at the correct abstraction level.

Do not mix all levels at once.

---

# Abstraction Rule

AltarSky work happens at multiple abstraction levels.

Higher-level hats should not get pulled into low-level work unless intentionally switching hats.

Lower-level hats should not rewrite high-level rules while working.

Examples:

- Developer Hat should not rewrite the Developer Operating System during coding.
- Project Manager Hat should not rewrite hat rules during planning.
- Visionary Hat should not force every good idea into the active sprint.
- Documentation Architect Hat should not change project priorities unless switching to Project Manager Hat.
- Development Systems Architect Hat should not accidentally become game implementation unless intentionally switching to Developer Hat.

If a hat notices something that belongs to another hat, capture it and continue unless the user explicitly chooses to switch.

---

# Repo Source-of-Truth Rule

The repo docs are the source of truth.

The AI should use memory as support, not as authority.

When project instructions, workflow rules, or document relationships matter, use the repo docs.

Current top-level control docs:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Working docs:

- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`
- `docs/systems/*.md`
- `docs/game_flow/*.md`
- `docs/01_devlogs/*.md`

---

# Hat System

A hat is the role or work mode being used for the current session.

The hat controls:

- What the user/AI should care about.
- What the user/AI should ignore.
- What docs should be read.
- What docs may be updated.
- What outputs should be produced.
- What questions should be asked.
- What handoff or parking steps are required.

The user may explicitly switch hats by saying:

- "I am switching to Developer Hat."
- "Put me in Project Manager Hat."
- "I want to wear Visionary Hat today."
- "Switch to Documentation Architect mode."
- "We are Development Systems Architect right now."

When that happens, follow the Hat Switching Rule.

---

# Hat Switching Rule

When a hat switch is detected:

1. Identify the target hat.
2. Identify the previous hat if known.
3. Check whether the previous hat requires handoff, parking, or closeout.
4. Confirm whether findings, notes, work, dirty-tree changes, or unfinished tasks are stored, parked, committed, stashed, deferred, or intentionally carried forward.
5. Run the target hat startup checklist.
6. Ask only the required immediate questions.
7. Open or reference the required docs.
8. Confirm the work mode before proceeding.

Hat switching should not happen blindly.

Some transitions require handoff.

If the user says they are taking off a hat but does not name the next hat:

1. Identify the hat being removed.
2. Confirm what must be stored, parked, committed, stashed, deferred, or carried forward.
3. Ask which hat the user is putting on next.
4. Recommend the likely next hat if obvious.
5. Do not fully switch hats until the user confirms the next hat or a default has been explicitly defined.

AI must use official hat names from this workflow document.

If a new hat seems needed, park that as a Developer OS improvement instead of inventing or using an unofficial hat name during active work.

Examples:

Developer to Visionary:

- Park active task state first.
- Capture current file/task if needed.
- Then allow idea exploration.

Visionary to Developer:

- Filter ideas against current sprint scope.
- Select one actionable task or return to prior task.
- Park extra ideas before coding.

Developer to Documentation Architect:

- Capture what changed.
- Identify affected docs.
- Decide update now vs deferred TODO.

Project Manager to Scrum Master:

- Convert project priorities into sprint tasks.
- Confirm sprint scope and blockers.

Development Systems Architect to any other hat:

- Capture operating-system changes or TODOs before leaving the meta-layer.

---

# Universal Hat Startup Checklist

When starting or switching into any hat, ask:

1. What hat are we wearing?
2. What are we trying to accomplish in this hat?
3. Are we continuing from another hat?
4. Is there anything from the previous hat that must be parked or handed off?
5. Which source docs should be checked first?
6. What output should this session produce?
7. What should not be touched in this hat?

Do not turn this into a long interrogation.

Ask only what is needed for the current task.

---

# Universal Hat Handoff Checklist

Before leaving a hat, check:

1. Was work completed?
2. Are there unfinished tasks to park?
3. Were decisions made?
4. Were blockers discovered?
5. Were ideas generated that belong to another hat?
6. Are documentation updates needed now?
7. Should a deferred TODO be added instead?
8. Are findings, validation results, or decisions safely stored?
9. Is the working tree clean, intentionally dirty, committed, stashed, or deferred?
10. Is a session log needed?
11. What hat is going on next?

If the previous hat was doing active implementation, preserve enough state to return later.

If the previous hat was QA / Tester, confirm that validation findings are logged, parked, or intentionally deferred before switching.

If the previous hat was Development Systems Architect, confirm that operating-system changes or TODOs are captured before leaving the meta-layer.

---

# Hat: Development Systems Architect

Also known as:

- Architect of Architects
- Operating System Architect

Purpose:

- Build and evolve the AltarSky Developer Operating System itself.

This is the meta-layer hat.

This hat designs:

- Hats
- Routing
- Workflows
- Templates
- Documentation architecture
- AI behavior rules
- Blowout mitigation
- System evolution rules
- Validation tests
- Local helper tool plans

Primary docs:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`
- `docs/sprints/current_sprint.md`

Should care about:

- The operating system itself.
- Whether the docs train the AI/user correctly.
- Whether the workflow prevents drift.
- Whether hats are clear.
- Whether tasks route to correct docs.
- Whether future additions have a proper place.

Should ignore:

- Game code implementation.
- Asset polish.
- Gameplay tuning.
- Feature work outside the operating system.
- Deep game design unless it affects workflow structure.

Outputs:

- Updated `00_ReadMeFirst/` docs.
- New or updated templates.
- Hat definitions.
- Workflow rules.
- AI guidance rules.
- System improvement backlog items.
- Validation tests.
- System evolution notes.

Startup questions:

1. What part of the Developer Operating System are we evolving?
2. Is this a new rule, a new process, a new template, a new hat, or a clarification?
3. Which high-level docs are affected?
4. Should this be implemented now or parked as an improvement note?
5. Will this change require updates to working docs or templates?

Handoff requirements:

- Capture any unintegrated OS ideas.
- Update or park changes before switching hats.
- Do not leave half-applied workflow changes undocumented.

---

# Hat: Project Manager

Purpose:

- Use the Developer Operating System to manage AltarSky priorities, scope, roadmap, release direction, and project-level decisions.

Primary docs:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`
- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`

Should care about:

- What matters next.
- Current release target.
- Current sprint alignment.
- Scope control.
- Roadmap direction.
- Release blockers.
- What should become active vs deferred.
- Whether the team is working on the right thing.

Should ignore:

- Low-level implementation details unless they affect scope.
- Rewriting the Developer Operating System.
- Over-editing documentation structure.
- Doing Scrum Master task tracking unless switching hats.
- Coding.

Outputs:

- Priority decisions.
- Scope decisions.
- Roadmap updates.
- Release tracker updates.
- Sprint direction.
- Deferred idea decisions.
- Work sequencing.

Startup questions:

1. What project-level decision are we making?
2. What release or sprint does this affect?
3. Is this current scope or future scope?
4. Does this change the roadmap or release tracker?
5. Does this need to become a sprint task?

If Project Manager notices OS friction:

- Capture it as a Developer OS improvement note.
- Do not rewrite the operating system unless switching to Development Systems Architect Hat.

Handoff to Scrum Master:

- Convert priorities into sprint tasks.
- Identify blockers.
- Identify what must move into current sprint, next sprint, or planning.

---

# Hat: Scrum Master / Sprint Operator

Purpose:

- Run sprint planning, active task tracking, blockers, completed work tracking, sprint closeout, and sprint reset.

Primary docs:

- `docs/sprints/current_sprint.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/planning/roadmap.md`
- `docs/01_devlogs/`

Should care about:

- Current sprint goal.
- Active tasks.
- Completed tasks.
- Blockers.
- Decisions.
- Deferred ideas.
- Documentation TODOs.
- Sprint closeout.
- Next sprint setup.

Should ignore:

- Big future design unless it affects sprint planning.
- Operating-system redesign unless switching hats.
- Low-level coding unless confirming task status.

Outputs:

- Updated current sprint.
- Active task list.
- Completed task list.
- Blocker list.
- Closeout notes.
- Next sprint candidate tasks.
- Reset sprint doc from template.

Startup questions:

1. Are we planning, updating, or closing a sprint?
2. What is the current sprint goal?
3. What tasks are active?
4. What tasks are complete?
5. What blockers exist?
6. What needs to be carried forward?
7. What docs need updates now or later?

Closeout responsibilities:

- Preserve completed work.
- Move completed work into devlogs/history/milestones.
- Move release-impacting changes into release tracker.
- Move system changes into system docs.
- Move player-flow changes into game-flow docs.
- Move future ideas into planning.
- Move unfinished work into next sprint.
- Reset current sprint from template after preservation.

---

# Hat: Documentation Architect

Purpose:

- Maintain documentation quality, structure, discoverability, maintenance notes, cross-links, templates, and no-orphan-doc rules.

Primary docs:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/templates/`
- Any affected working docs

Should care about:

- Broken paths.
- Stale references.
- Missing maintenance notes.
- Duplicate docs.
- Orphan docs.
- Folder structure.
- Template consistency.
- Markdown formatting.
- Whether docs are discoverable.

Should ignore:

- Project priority decisions unless switching to Project Manager.
- Code implementation.
- Game design expansion unless it affects doc structure.

Outputs:

- Cleaned docs.
- Updated maintenance notes.
- Updated cross-references.
- Updated document map.
- Template updates.
- Documentation TODO resolution.

Startup questions:

1. What documentation problem are we fixing?
2. Which docs are affected?
3. Are there stale paths or broken links?
4. Does a maintenance note need updating?
5. Does the project document map need updating?
6. Should this be done now or deferred?

Rules:

- Follow `docs/00_ReadMeFirst/01_documentation_guide.md`.
- Do not create orphan docs.
- Update related docs in the same commit when practical.
- Use exact paths.
- If related updates are deferred, leave a clear TODO.

---

# Hat: Developer

Purpose:

- Implement code, scenes, gameplay systems, UI behavior, assets, and technical changes according to current sprint scope.

Primary docs:

- `docs/sprints/current_sprint.md`
- Relevant `docs/systems/*.md`
- Relevant `docs/game_flow/*.md`
- Relevant scene map docs after they exist
- Relevant scripts/scenes/assets

Should care about:

- Active task.
- Current sprint scope.
- Relevant system behavior.
- Relevant implementation files.
- Debugging and validation.
- Clean focused commits.

Should ignore:

- Major roadmap restructuring.
- Future feature expansion.
- Operating-system changes.
- Documentation architecture changes.
- Random idea expansion.

Outputs:

- Code changes.
- Scene changes.
- Asset changes.
- Focused commits.
- Completed task notes.
- Bug notes.
- Deferred documentation TODOs when needed.

Startup questions:

1. What active sprint task are we implementing?
2. Which system or scene is affected?
3. What file(s) are likely involved?
4. What is in scope?
5. What is explicitly out of scope?
6. How will we validate it?
7. What docs may need updates after implementation?

During development:

- Give one instruction at a time unless the user asks for a full plan.
- Keep scope tight.
- Park out-of-scope ideas.
- Do not interrupt constantly for documentation.
- At natural stopping points, ask whether to update docs now or add a deferred TODO.

Handoff requirements:

- Capture changed files.
- Capture completed work.
- Capture bugs/blockers.
- Capture deferred docs.
- Confirm git status before leaving the hat if code was changed.

---

# Hat: QA / Tester

Purpose:

- Test builds, validate behavior, find bugs, record performance issues, device notes, regressions, and verification results.

Primary docs:

- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- Relevant `docs/systems/*.md`
- Relevant `docs/game_flow/*.md`
- Debug console docs
- Future QA or device notes docs if created

Should care about:

- Repro steps.
- Expected behavior.
- Actual behavior.
- Device/build environment.
- Performance.
- Regression risk.
- Pass/fail validation.
- Release blockers.

Should ignore:

- Fixing the issue unless switching to Developer.
- Changing scope unless switching to Project Manager.
- Rewriting docs unless switching to Documentation Architect.

Outputs:

- Bug notes.
- QA findings.
- Performance notes.
- Repro steps.
- Validation results.
- Blocker updates.
- Release readiness notes.

Startup questions:

1. What are we testing?
2. What build/device/environment?
3. What is expected to happen?
4. What actually happened?
5. Is this a blocker?
6. Which sprint/release/system doc does this affect?

---

# Hat: Visionary / Concept Designer

Purpose:

- Explore big ideas, lore, mechanics, future systems, game identity, progression, economy, worldbuilding, and long-term vision.

Primary docs:

- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- Future idea inbox if created
- Relevant systems/planning docs

Should care about:

- Big-picture game direction.
- Player experience.
- Lore.
- Mechanics.
- Future features.
- Emotional tone.
- Long-term identity.
- Novel ideas.

Should ignore:

- Current sprint implementation unless intentionally routing ideas into planning.
- Release commitments unless reviewed by Project Manager.
- Code details.
- Overloading active scope.

Outputs:

- Idea notes.
- Concept notes.
- Future system candidates.
- Planning entries.
- Questions for Project Manager review.
- Deferred ideas.

Startup questions:

1. What idea or concept are we exploring?
2. Is this current release, future release, or long-term vision?
3. Does this need to be parked, expanded, or converted to a planning doc?
4. Should Project Manager review it later?
5. Does it affect existing lore/system docs?

Rule:

- Visionary work should be free to explore, but it should not force itself into the active sprint.

---

# Hat: Art Director / Asset Creator

Purpose:

- Handle sprite direction, visual hierarchy, animation references, pixel-art rules, asset requirements, environment readability, and visual polish.

Primary docs:

- `docs/sprints/current_sprint.md`
- Relevant `docs/systems/*.md`
- Relevant future art/asset docs if created
- Relevant scene maps after they exist
- Planning docs for future art direction

Should care about:

- Visual identity.
- Player readability.
- Sprite perspective.
- Pixel-art consistency.
- Animation references.
- Environment readability.
- Combat readability.
- Asset requirements.
- Import/usage constraints.

Should ignore:

- Code implementation unless asset integration requires it.
- Operating-system changes.
- Project scope expansion unless switching hats.

Outputs:

- Asset direction notes.
- Art requirements.
- Visual hierarchy rules.
- Reference notes.
- Deferred art tasks.
- Asset update TODOs.

Startup questions:

1. What asset or visual system are we working on?
2. Is this current sprint scope?
3. What visual rule must be preserved?
4. What does the asset need to communicate?
5. What docs or scene maps need updates?

---

# Hat: Release Manager

Purpose:

- Check release readiness, completion criteria, blockers, and what must happen before release milestones.

Primary docs:

- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`
- `docs/sprints/current_sprint.md`
- Relevant system/game-flow docs
- QA notes

Should care about:

- Release requirements.
- Completion criteria.
- Blockers.
- Risk.
- Missing systems.
- Validation.
- Release readiness.

Should ignore:

- Future ideas outside release scope.
- Low-level implementation unless it blocks release.
- Operating-system changes unless they affect release readiness.

Outputs:

- Release readiness notes.
- Release tracker updates.
- Blocker list.
- Go/no-go recommendations.
- Scope clarification.

Startup questions:

1. Which release are we evaluating?
2. What criteria are complete?
3. What criteria are blocked?
4. What needs validation?
5. What must happen before release can proceed?

---

# Hat: Git / Integration Operator

Purpose:

- Maintain branch hygiene, commit hygiene, staging separation, merges, pushes, and repo safety.

Primary docs:

- `docs/sprints/current_sprint.md`
- Current Git state
- Relevant workflow/git hygiene rules

Should care about:

- Current branch.
- Working tree status.
- Staged vs unstaged changes.
- Untracked files.
- Commit boundaries.
- Push status.
- Merge safety.
- Duplicate folder/path confusion.
- Clean history.

Should ignore:

- Feature design unless needed to label commits.
- Documentation rewrites unless staging docs.
- Code changes unless reviewing staged content.

Outputs:

- Clean commits.
- Clean push state.
- Merge plan.
- Branch cleanup notes.
- Repo safety checks.

Startup questions:

1. What branch are we on?
2. What does `git status` show?
3. What files changed?
4. Are changes docs, code, scenes, assets, or tuning?
5. Should changes be split into multiple commits?
6. Has the branch been pushed?
7. Is the working tree clean?

Rules:

- Do not use `git add .` when changes should be separated.
- Stage docs separately from code when practical.
- Commit tuning separately from system rewrites when practical.
- Push only after status and commits are verified.
- Confirm clean status after push.
- If paths look wrong, stop and investigate.

Known path lesson:

- Real Godot project path:
  - `~/Projects/GamerPal/AltarskyGame`
- Symlink path:
  - `~/Projects/AltarskyGame`
- Old duplicate folder was quarantined:
  - `~/Projects/AltarskyGame_OLD_DO_NOT_USE`

---

# Hat: Product / Platform Strategist

Purpose:

- Connect AltarSky to GamerPal, branding, app positioning, platform strategy, user onboarding, monetization boundaries, and long-term product identity.

Primary docs:

- `docs/planning/roadmap.md`
- Future product/platform docs if created
- Release roadmap
- Planning docs

Should care about:

- GamerPal relationship.
- App positioning.
- Branding.
- User acquisition.
- Platform strategy.
- Product ecosystem.
- Monetization boundaries.
- Long-term identity.

Should ignore:

- Low-level implementation.
- Active sprint disruption.
- Operating-system changes unless switching hats.

Outputs:

- Product strategy notes.
- Branding ideas.
- Platform integration plans.
- Future roadmap notes.
- Questions for Project Manager review.

---

# Blowout Mitigation / Idea-Catching System

A blowout is when a valuable idea, concern, or tangent appears while wearing a hat that should not act on it immediately.

The system should catch blowouts without losing them and without derailing current work.

The AI should detect when the user starts drifting into a different hat.

Examples:

- Developer starts exploring future lore.
- Project Manager starts redesigning the operating system.
- Visionary starts assigning sprint tasks.
- Documentation Architect starts changing release scope.
- QA starts implementing fixes.
- Art Director starts redesigning the roadmap.

When this happens, the AI should respond with one of:

- Park it.
- Switch hats.
- Continue current task.
- Create a handoff note.
- Ask whether the user wants to change modes.

Example AI response:

"This sounds like Visionary Hat work. Do you want to switch hats, or should we park this idea and return to the Developer task?"

---

# Idea Parking Workflow

When an idea appears, classify it:

1. Current sprint scope
2. Future planning
3. Developer OS improvement
4. Documentation TODO
5. Bug/blocker
6. Art/asset note
7. Release concern
8. Product/platform idea

If current sprint scope:

- Add to `docs/sprints/current_sprint.md` under active tasks or notes.

If future planning:

- Park in current sprint deferred ideas for later review.
- Later move to `docs/planning/` if it survives review.

If Developer OS improvement:

- Park under Developer OS Improvement Notes.
- Review later while wearing Development Systems Architect Hat.

If documentation TODO:

- Add to `docs/sprints/current_sprint.md` under Documentation TODO / Deferred Updates.

If bug/blocker:

- Add to current sprint blocker section or QA notes.

If release concern:

- Add to release tracker or current sprint blocker section.

Default rule:

- Park first.
- Process later under the correct hat.

---

# Documentation Deferral Workflow

Do not interrupt active implementation constantly for documentation.

At natural stopping points, ask:

- Update docs now?
- Add a deferred documentation TODO?
- Generate a session log?

Use deferred documentation TODOs when:

- The user is actively coding.
- The change is not stable yet.
- The related docs are not ready.
- The update would derail the current hat.
- The user explicitly wants to batch docs later.

Deferred TODOs should include:

- What changed.
- Which docs are affected.
- Why update is deferred.
- Which hat should review it later.

Default temporary location:

- `docs/sprints/current_sprint.md`

---

# AI Continuous Improvement Check

When the AI reads or uses the AltarSky Developer Operating System, it should briefly look for one possible improvement, friction point, missing rule, unclear path, repeated manual action, or drift risk.

Before suggesting a new improvement, the AI should check existing improvement notes, current sprint deferred notes, or the active Developer OS backlog to avoid repeating the same suggestion.

If the improvement is already captured:

- Do not repeat it.
- Only add to it if there is genuinely new detail.

If the improvement is new:

- Give the user a short note explaining the improvement.
- Provide a fast copy-paste block or terminal command to update the improvement idea park log when practical, using the quickest safe terminal-based method possible.
- Tell the user exactly where to paste or append it.
- When practical, prefer a fast terminal append command or exact paste block over vague instructions.

This system also helps offset AI memory/context burden. The repo becomes the external memory and source of truth. The user hosts the durable project knowledge in Git, while the AI reads, follows, and contributes to that system instead of carrying everything internally.

Default temporary parking location:

- `docs/sprints/current_sprint.md`

Suggested section name:

- `Developer OS Improvement Notes`

Possible future dedicated backlog:

- `docs/planning/developer_os_improvement_backlog.md`

The Development Systems Architect Hat should periodically review parked improvement notes and decide whether to:

- Ignore them.
- Merge them into an existing rule.
- Add them to a template.
- Update `00_start_here.md`.
- Update `01_documentation_guide.md`.
- Update `02_project_document_map.md`.
- Update `03_development_workflow.md`.
- Create a new support document.

This loop exists to prevent system drift and continuously improve the workflow during every AI pass without interrupting active development.

---

# Session Workflow

Use this workflow for normal work sessions.

1. Start from `docs/00_ReadMeFirst/00_start_here.md`.
2. Identify why the user is here.
3. Identify the active hat.
4. If hat is unknown, run hat onboarding.
5. If switching hats, run hat handoff.
6. Open or reference source docs.
7. Confirm task.
8. Work within the hat.
9. Park out-of-scope items.
10. At natural stopping point, update docs or defer.
11. Generate session log if needed.
12. Confirm next step.

---

# End-of-Session Workflow

At the end of a session:

1. Identify active hat.
2. Summarize what happened.
3. List completed work.
4. List decisions made.
5. List blockers or risks.
6. List ideas parked.
7. List docs updated.
8. List docs still needing updates.
9. Recommend next step.
10. Ask whether to generate a session log.

If the user requests a session log, generate a copy-paste block with:

- Date
- Active hat
- Session goal
- Work completed
- Decisions made
- Files changed
- Blockers or risks
- Ideas captured
- Documentation TODOs
- Next recommended step
- Paste destination

Default paste destination:

- `docs/sprints/current_sprint.md`

If the work is historically significant, create or update a devlog instead.

---

# Sprint Workflow

Sprint lifecycle:

1. Sprint planning
2. Active work
3. Task completion
4. Decision capture
5. Blocker tracking
6. Deferred idea capture
7. Documentation TODO capture
8. Sprint closeout
9. Sprint reset
10. Next sprint setup

`docs/sprints/current_sprint.md` is the active sprint workspace.

Do not delete completed sprint information.

Move completed tasks into a completed section once the sprint template exists.

Use sprint closeout to move information into permanent docs.

---

# Sprint Closeout Workflow

At sprint closeout:

1. Review `docs/sprints/current_sprint.md`.
2. Review active tasks.
3. Review completed tasks.
4. Review decisions.
5. Review blockers.
6. Review deferred ideas.
7. Review documentation TODOs.
8. Review Developer OS improvement notes.
9. Update devlogs/history.
10. Update project milestones if needed.
11. Update release tracker if release status changed.
12. Update system docs if system behavior changed.
13. Update game-flow docs if player flow changed.
14. Move future ideas to planning.
15. Move unfinished work to next sprint.
16. Preserve unresolved documentation TODOs.
17. Reset current sprint from template.
18. Fill in next sprint identity, branch, goal, scope, and first tasks.

Do not reset `current_sprint.md` from memory once the template exists.

Use:

- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

---

# Local Workflow Helper Tools

The operating system should eventually include small terminal tools to make repeated doc updates faster.

Possible folder:

- `tools/docs/`

Possible scripts:

- `tools/docs/add_os_improvement.sh`
- `tools/docs/park_idea.sh`
- `tools/docs/add_doc_todo.sh`
- `tools/docs/add_blocker.sh`
- `tools/docs/add_completed_task.sh`
- `tools/docs/add_session_log.sh`

Until scripts exist, the AI should provide fast safe terminal append commands or exact paste blocks when practical.

Rules:

- Do not use `sudo` for repo documentation updates.
- Prefer safe append commands before destructive edit commands.
- Prefer `cat <<'EOF' >> file.md` for quick parking.
- Always run `git diff -- docs` after scripted documentation updates.
- AI should tell the user exactly where a command writes or where a block should be pasted.

Example manual append pattern:

```bash
cat <<'EOF' >> docs/sprints/current_sprint.md

## Developer OS Improvement Notes

- [ ] Improvement idea:
  - Source hat:
  - Reason:
  - Review as:

EOF
```

---

# Git Hygiene Workflow

Before editing:

1. Confirm project path.
2. Confirm branch.
3. Confirm `git status`.

Before staging:

1. Review changed files.
2. Separate docs/code/scenes/assets/tuning where practical.
3. Avoid `git add .` if changes should be split.

Before commit:

1. Review staged files.
2. Confirm commit scope.
3. Use clear commit message.

Before push:

1. Confirm working tree status.
2. Confirm branch.
3. Push.
4. Confirm clean status after push.

If there is path confusion:

- Stop.
- Run `pwd`.
- Run `readlink -f .`.
- Run `git status`.
- Confirm Godot project path.

Before implementation work begins, the working tree should be clean unless the dirty state is intentional.

If `git status --short` shows changes before implementation:

1. Inspect the dirty files.
2. Classify the changes as code, docs, scenes, assets, tuning, validation notes, or unknown.
3. Recommend one of:
   - Commit
   - Stash
   - Discard
   - Explicit dirty-tree acceptance
4. Do not proceed into implementation until the user chooses one.

If the user says they want to code anyway with a dirty tree, gently push back once and explain the risk.

If the user explicitly accepts the dirty-tree risk after inspection, continue, but mention the dirty state in the next handoff or session log if relevant.

When asking the user to paste diff output, prefer:

```bash
git --no-pager diff -- <path>
```

over plain `git diff`, so the terminal does not get stuck in a pager.

---

# AI Guidance Rules

The AI should:

- Identify the user's likely hat.
- Use official hat names from this workflow document.
- Repeat back the interpreted task when helpful.
- Ask only necessary immediate questions.
- Give one instruction at a time during active implementation unless the user asks for a full plan.
- Provide one complete uninterrupted block when the user asks for copy-paste content.
- Format terminal commands as clean multi-line commands.
- Prefer exact terminal commands or paste destinations over vague instructions.
- Prefer `git --no-pager diff` over plain `git diff` when asking the user to paste diff output.
- Park out-of-scope ideas instead of derailing.
- Prefer existing sprint sections when parking notes:
  - `Good Ideas / Not Current Scope`
  - `Developer OS Improvement Notes`
  - `Documentation TODO / Deferred Updates`
  - `Session Logs / Work Notes`
  - `QA / Validation Notes`
  - `Git / Integration Notes`
- Ask for the actual idea before generating an idea-parking command when practical.
- Ask "what changed?" before routing a vague documentation-update request.
- Include a paste destination or terminal append command when generating a Stand-Down Update or session log that should be saved.
- Remind about docs at natural stopping points.
- Check for duplicate improvement suggestions before proposing new ones.
- Treat repo docs as source of truth.
- Be honest when docs are missing, stale, or unclear.

The AI should not:

- Assume the user is coding.
- Invent new hat names during active work.
- Rewrite operating-system rules from a lower-level hat.
- Push major scope changes into active sprint without Project Manager review.
- Tell the user vaguely to "update docs" when a specific paste block or command would be better.
- Continue after a hat switch without checking required handoff/startup steps.
- Proceed into implementation with a dirty tree unless the user has committed, stashed, discarded, or explicitly accepted the dirty-tree risk after inspection.

---

# AI Behavior Validation Loop

AI behavior validation is an official workflow.

Use this workflow when testing whether an AI session follows the Developer Operating System correctly.

Primary hat:

- QA / Tester

Supporting hat:

- Development Systems Architect

Process:

1. Start in QA / Tester Hat.
2. Run a defined validation prompt.
3. Compare expected behavior against actual behavior.
4. Mark the result as:
   - Pass
   - Partial pass
   - Fail
5. Capture the exact friction or failure.
6. Decide whether the issue is:
   - Prompt issue
   - Missing workflow rule
   - Missing hat rule
   - Missing documentation path
   - Missing helper script
   - AI behavior limitation
7. Park findings during the validation batch.
8. After the batch, switch to Development Systems Architect Hat.
9. Convert findings into OS rule updates.
10. Retest after the rules are updated.

Validation prompts may include:

- "I am switching to Developer Hat."
- "I am switching from Developer Hat to Visionary / Concept Designer Hat."
- "Time to update docs."
- "Close out this sprint."
- "I have a good idea but I am coding."
- "I know this is out of scope, but I want to implement it anyway."
- "I want to evolve the operating system."
- "Where does this note belong?"
- "Generate a Stand-Down Update for this session."
- "What should I work on next?"

Validation result format:

- Test name:
- Prompt used:
- Expected behavior:
- Actual behavior:
- Result:
  - Pass
  - Partial pass
  - Fail
- Correction needed:
- Affected docs:
- Retest needed:

Success condition:

- AI routes correctly.
- AI asks the right warm-up questions.
- AI does not overload the user.
- AI captures ideas without derailment.
- AI knows when to update docs vs defer.
- AI follows repo docs instead of relying only on memory.
- AI checks handoff requirements when hats change.
- AI handles dirty-tree state before implementation.
- AI gives clean, pasteable terminal commands.
- AI gives paste destinations or append commands when generating session logs.

---

# System Evolution Workflow

The Developer Operating System is alive.

It is expected to evolve.

When the system itself needs to change:

1. Switch to Development Systems Architect Hat.
2. Capture the reason for the change.
3. Identify which `00_ReadMeFirst/` docs are affected.
4. Update high-level rules first.
5. Update templates if needed.
6. Update working docs only after high-level rule is stable.
7. Preserve prior reasoning in design notes or devlogs if the change is significant.
8. Test the AI/user flow after the change.

Other hats may generate OS improvement notes.

Only Development Systems Architect should approve and integrate operating-system changes.

---

# Open Workflow Questions

Open questions:

- Should hat-specific checklists eventually become separate docs if this file gets too large?
- Should Developer OS improvement notes stay in `docs/sprints/current_sprint.md` or move to `docs/planning/developer_os_improvement_backlog.md`?
- Should session logs get their own template immediately or wait until the first repeated need?
- Should local helper tools be built before or after current sprint template?
- Should AI validation tests live in this document or become a separate `04_ai_validation_tests.md` later?
- Should scene map documentation be added before or after player soul core documentation?
- Should new maintainer onboarding be included in `00_start_here.md` for now or split later?

---

# Final Rule

This workflow exists to help AltarSky move faster without losing control.

Use the correct hat.

Use the correct source docs.

Park what does not belong.

Update or defer documentation intentionally.

Preserve completed work.

Do not let the system drift.

The repo is the source of truth.
