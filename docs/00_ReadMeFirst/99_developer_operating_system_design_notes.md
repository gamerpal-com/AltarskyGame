# Developer Operating System Design Notes

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update if documentation rules, folder structure, naming rules, maintenance-note rules, template rules, or no-orphan-doc rules change.
> - `docs/00_ReadMeFirst/00_start_here.md` — update after it is created if top-level routing, first questions, hat onboarding, project onboarding, or AI entry behavior changes.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update after the existing guide is renamed/split if documentation rules or folder glossary rules change.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update after it is created if document relationships, document purposes, project-state sources, history/now/future routing, or document feed rules change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — update after it is created if hats, role switching, workflow steps, session closeout, sprint closeout, AI guidance, blowout mitigation, or git hygiene rules change.
> - `docs/00_ReadMeFirst/templates/current_sprint_template.md` — update after it is created if the required sprint structure or sprint reset process changes.
> - `docs/sprints/current_sprint.md` — update when this design work changes active sprint scope, deferred documentation TODOs, current tasks, completed tasks, or sprint closeout requirements.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if documentation infrastructure becomes part of Pre-Alpha 0.1 completion criteria or release readiness.
>
> This is a temporary design scaffold. It captures the raw architecture for the AltarSky Developer Operating System before the final control documents are created or split.
>
> Do not treat this file as the final operating system. Use it to build the final system, then either archive it, keep it as design history, or replace it with the finalized `00_ReadMeFirst/` documents.

---

# Purpose

This document captures the design scaffold for the AltarSky Developer Operating System.

The purpose of this system is to create an external, repo-based source of truth that helps the user, the AI, and future teammates understand:

- What AltarSky is.
- What has already happened.
- What is happening now.
- What is planned for the future.
- What role or "hat" is being worn during a work session.
- Which documents should be read before acting.
- Which documents should be updated after acting.
- How to avoid derailing active work.
- How to preserve ideas, tasks, decisions, blockers, and documentation debt.
- How to evolve the operating system itself over time.

This system is not just documentation.

It is a role-aware workflow system for developing AltarSky.

The repo docs are the source of truth.

The AI should follow the repo docs, not replace them.

---

# Current Mode

Current work mode:

- Development Systems Architect Hat

Current mission:

- Pause AltarSky game development.
- Build the Developer Operating System.
- Test the AI against the system before returning to game implementation.

Current branch:

- `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`

Current active sprint context:

- Sky Layer Manager Depth & Lighting sprint is still the active game-development sprint.
- Development is temporarily paused to build documentation/workflow scaffolding.
- This operating-system work should be recorded in `docs/sprints/current_sprint.md` as documentation/workflow system work.

---

# Core Concept

AltarSky development should be organized as a pyramid.

The top of the pyramid should be simple.

The lower levels may be deeper and more detailed.

The system should allow the user or AI to move up and down abstraction levels without mixing responsibilities.

Examples:

- When wearing Developer Hat, focus on implementation.
- When wearing Project Manager Hat, focus on scope, priorities, and release direction.
- When wearing Visionary Hat, explore ideas without forcing them into the active sprint.
- When wearing Documentation Architect Hat, organize and maintain docs.
- When wearing Development Systems Architect Hat, evolve the operating system itself.

The system should prevent every session from becoming "do everything at once."

---

# Abstraction Principle

Each hat operates at a different abstraction level.

Higher-level hats should not get dragged into low-level implementation unless they intentionally switch hats.

Lower-level hats should not casually rewrite the operating system while doing active work.

If a lower-level hat discovers a problem with a higher-level system, it should capture the issue as a deferred note for the correct hat.

Examples:

- Developer notices the workflow is annoying.
  - Do not rewrite the workflow mid-development.
  - Add an OS improvement note for Development Systems Architect review.

- Project Manager notices documentation structure is confusing.
  - Do not rewrite all docs mid-planning.
  - Add a Documentation Architect or Development Systems Architect note.

- Visionary has a major future feature idea during a coding session.
  - Do not derail the coding session.
  - Capture the idea and return to the active task.

---

# Rule Inheritance Principle

High-level documents contain full rules.

Low-level working documents contain short local reminders and exact cross-references.

This allows rule compliance without reopening every top-level document during every edit.

High-level rule docs:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`

Working docs:

- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`
- `docs/systems/*.md`
- `docs/game_flow/*.md`
- `docs/01_devlogs/*.md`

Working docs should not duplicate the whole operating system.

They should include:

- A short maintenance note.
- Exact related paths.
- A short rule reminder.
- Clear update responsibility.

---

# Planned `00_ReadMeFirst/` Pyramid

The final `00_ReadMeFirst/` structure should become:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

Additional templates may be added later only when needed.

Possible later templates:

- `docs/00_ReadMeFirst/templates/session_log_template.md`
- `docs/00_ReadMeFirst/templates/devlog_template.md`
- `docs/00_ReadMeFirst/templates/system_doc_template.md`
- `docs/00_ReadMeFirst/templates/game_flow_template.md`
- `docs/00_ReadMeFirst/templates/planning_doc_template.md`

---

# Planned Top-Level Control Documents

## `00_start_here.md`

Purpose:

- Front door to the AltarSky Developer Operating System.
- Briefly explains what the system is and why it exists.
- Tells the user/AI to read the whole start document first.
- Asks the first routing questions.
- Sends the user/AI to the correct deeper document.

It should not contain the full rules.

It should ask:

- Why are you here?
- What do you want to know or do?
- Do you need to understand the project?
- Do you already know what hat/work mode you are wearing?
- Are you starting work, switching hats, updating docs, closing a session, closing a sprint, or evolving the operating system?

It should include fallback paths:

- If you do not understand documentation rules, read `01_documentation_guide.md`.
- If you do not understand what docs exist or what they do, read `02_project_document_map.md`.
- If you do not understand hats, workflows, or session modes, read `03_development_workflow.md`.
- If you need current active work, read `docs/sprints/current_sprint.md`.

It should include a project onboarding branch:

- If you need to learn what AltarSky is, read `02_project_document_map.md`, then project-state docs such as roadmap, release tracker, history, and current sprint.

It should include a hat onboarding branch:

- If you do not know your hat, use the hat onboarding section in `03_development_workflow.md`.

After the hat system is finalized, revisit `00_start_here.md` and make sure all hats are addressable through the routing flow.

---

## `01_documentation_guide.md`

Purpose:

- Documentation rules.
- Folder glossary.
- Naming rules.
- Maintenance note rules.
- No orphan docs rule.
- Rules for creating and updating docs.

This is the documentation constitution.

It should answer:

- Where does information belong?
- What folder should a doc go in?
- What is a maintenance note?
- How should related docs be updated?
- How do we avoid orphan docs?
- What naming convention is used?

It should not become the full workflow brain.

It should point to:

- `00_start_here.md` for entry/routing.
- `02_project_document_map.md` for document ecosystem and project-state map.
- `03_development_workflow.md` for hats, workflow, sprint lifecycle, AI behavior, and session closeout.

---

## `02_project_document_map.md`

Purpose:

- Map the project documentation ecosystem.
- Explain what each document type does.
- Explain what actual documents currently exist.
- Explain what feeds into what.
- Explain where project identity, history, now, and future live.

This is the project brain map.

It should have two main sections:

1. Document Types / Templates / High-Level Rules
2. Active Project Documents

### Section 1 — Document Types / Templates / High-Level Rules

This section defines document categories, not individual docs.

Examples:

- Start-here document
- Documentation guide
- Project document map
- Development workflow
- Sprint document
- Sprint template
- Release tracker
- Release roadmap
- Roadmap
- Planning doc
- Idea inbox or deferred ideas area
- System doc
- Game-flow doc
- Devlog
- Project milestones
- Session log
- Template

Each type should define:

- Purpose
- Updated when
- Feeds into
- Fed by
- Related template, if any
- Closeout behavior, if any

### Section 2 — Active Project Documents

This section lists actual docs that exist now.

For each document, define:

- Path
- Type
- Purpose
- Updated when
- Feeds into
- Fed by
- Notes

Examples:

- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`
- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`
- `docs/systems/*.md`
- `docs/game_flow/*.md`

This doc should allow an AI or new teammate to understand:

- What AltarSky is.
- What has been done.
- What is happening now.
- What is planned later.
- Which doc is the source of truth for a topic.

---

## `03_development_workflow.md`

Purpose:

- Explain how work happens.
- Define hats/work modes.
- Define hat switching.
- Define hat startup and handoff checklists.
- Define session workflow.
- Define sprint workflow.
- Define idea capture.
- Define blowout mitigation.
- Define documentation deferral.
- Define git hygiene.
- Define AI behavior.

This is the Developer Operating System.

It should answer:

- What hat are we wearing?
- How do we start work?
- How do we avoid derailment?
- How do we capture ideas?
- How do we move tasks from active to completed?
- How do completed tasks become devlogs, milestones, release tracker updates, system docs, game-flow docs, or planning docs?
- How do we end a session?
- How do we end a sprint?
- How do we switch hats?
- How do we update the operating system itself?

---

# Templates

Templates should live in:

- `docs/00_ReadMeFirst/templates/`

Templates are reusable blank structures.

They prevent resets from being rebuilt from memory.

Initial required template:

- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

Possible future templates:

- `session_log_template.md`
- `devlog_template.md`
- `system_doc_template.md`
- `game_flow_template.md`
- `planning_doc_template.md`

Rule:

- Do not overbuild templates before they are needed.
- Start with the sprint template.
- Add more templates when a repeated workflow proves it needs one.

---

# Current Sprint Template Requirement

The sprint template should include at least:

- Sprint Identity
- Current Branch
- Release Target
- Sprint Status
- Sprint Goal
- In Scope
- Out of Scope
- Active Tasks
- Completed This Sprint
- Decisions Made This Sprint
- Blockers / Risks
- Good Ideas / Not Current Scope
- Documentation TODO / Deferred Updates
- Session Logs / Work Notes, if needed
- Sprint Closeout Checklist
- Next Sprint Candidate Tasks

At the end of a sprint:

1. Review `docs/sprints/current_sprint.md`.
2. Move completed work into devlogs, history, milestones, release tracker, systems docs, game-flow docs, or planning docs.
3. Move unfinished work into the next sprint.
4. Preserve unresolved documentation TODOs.
5. Reset `docs/sprints/current_sprint.md` from `docs/00_ReadMeFirst/templates/current_sprint_template.md`.
6. Fill in the new sprint identity, branch, goal, scope, and first tasks.

Never reset `current_sprint.md` from memory.

Always reset it from the template.

---

# Session Logs

The system should support manual session logs for now.

Future automation may generate or collect logs automatically.

For now, the AI should be able to generate a copy-paste session log when requested.

Session log should include:

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

Possible paste destinations:

- `docs/sprints/current_sprint.md`
- `docs/01_devlogs/pre_alpha_0_1/`
- `docs/01_devlogs/project_milestones.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- Related `docs/systems/`
- Related `docs/game_flow/`
- Related `docs/planning/`

AI instruction:

- When the user requests an end-of-session log, generate a completed session log using the active hat, current task, completed work, decisions, blockers, deferred ideas, and documentation TODOs.
- Tell the user exactly where to paste it.

---

# Current Initial Hat List

The system should support hats/work modes.

Hats are role-based operating modes.

A hat defines:

- Purpose
- What to read
- What to ignore
- What questions to ask
- What outputs to produce
- What docs may be updated
- What docs should not be touched
- Startup checklist
- Handoff checklist
- Blowout mitigation rules

Initial hats:

## Development Systems Architect

Also called:

- Architect of Architects
- Operating System Architect

Purpose:

- Builds and evolves the Developer Operating System itself.
- Defines hats, workflows, templates, source-of-truth rules, routing, AI guidance, and system evolution process.

This is the hat being worn during this design work.

Should care about:

- `00_ReadMeFirst/` docs.
- Documentation architecture.
- Role/hats.
- Workflow.
- Templates.
- AI operating contract.
- Rule inheritance.
- System evolution.

Should not focus on:

- Implementing game code.
- Tuning gameplay.
- Doing low-level art polish.
- Solving sprint tasks unless the task is part of the operating-system design.

Outputs:

- Updated `00_ReadMeFirst/` docs.
- New workflow rules.
- New templates.
- Hat definitions.
- System evolution notes.
- Backlog items for future OS improvements.

## Project Manager

Purpose:

- Uses the Developer Operating System to manage AltarSky priorities, roadmap, release direction, scope, and project-level decisions.

Should care about:

- Current release target.
- Roadmap.
- Release tracker.
- Current sprint.
- Scope.
- Priorities.
- What should happen next.

Should not directly change:

- The Developer Operating System itself.
- Hat definitions.
- Core workflow rules.

If the Project Manager notices OS friction:

- Capture an OS improvement note.
- Do not rewrite the OS mid-session.
- Later, Development Systems Architect reviews the note.

Outputs:

- Project priorities.
- Scope decisions.
- Roadmap updates.
- Release tracker updates.
- Sprint direction.
- Deferred ideas for planning.

## Scrum Master / Sprint Operator

Purpose:

- Runs sprint planning, active task tracking, blockers, completed work tracking, sprint closeout, and sprint reset.

Should care about:

- `docs/sprints/current_sprint.md`
- Sprint template.
- Active tasks.
- Completed tasks.
- Blockers.
- Documentation TODOs.
- Closeout checklist.
- Next sprint candidate tasks.

Outputs:

- Updated sprint doc.
- Completed task movement.
- Sprint closeout notes.
- Next sprint setup.
- Carried-forward tasks.

## Documentation Architect

Purpose:

- Maintains documentation quality, structure, cross-links, maintenance notes, templates, no-orphan-doc rules, and discoverability.

Should care about:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- All maintenance notes.
- Folder structure.
- Broken links.
- Duplicate docs.
- Empty or stale docs.

Outputs:

- Cleaned docs.
- Updated maintenance notes.
- Updated cross-references.
- Documentation TODO resolution.
- Template updates when needed.

## Developer

Purpose:

- Implements code, scenes, gameplay systems, UI behavior, assets, and technical changes according to current sprint scope.

Should care about:

- Current sprint task.
- Relevant system doc.
- Relevant scene/script files.
- Relevant debug/testing notes.

Should not focus on:

- Future feature expansion unless needed.
- Operating system changes.
- Major documentation architecture changes.
- Roadmap restructuring.

If a good idea appears:

- Capture it.
- Return to the active development task.

Outputs:

- Code changes.
- Scene changes.
- Focused commits.
- Completed task notes.
- Deferred documentation TODOs when needed.

## QA / Tester

Purpose:

- Tests builds, validates behavior, finds bugs, records performance issues, device notes, regressions, and verification results.

Should care about:

- Current sprint success conditions.
- Known issues.
- Release tracker.
- Device notes.
- Debug console.
- Performance notes.
- Repro steps.

Outputs:

- Bug notes.
- Validation results.
- Performance findings.
- Blocker updates.
- QA notes for sprint closeout.

## Visionary / Concept Designer

Purpose:

- Explores large ideas, lore, mechanics, future systems, game identity, progression, economy, worldbuilding, and long-term vision.

Should care about:

- Future possibilities.
- Player experience.
- Game identity.
- Lore consistency.
- Long-term mechanics.
- Planning docs.

Should not force ideas into:

- Current sprint.
- Release tracker.
- Implementation tasks unless reviewed by Project Manager/Scrum Master.

Outputs:

- Idea notes.
- Planning entries.
- Concept docs.
- Future system candidates.
- Questions for later review.

## Art Director / Asset Creator

Purpose:

- Handles sprite direction, visual hierarchy, animation references, pixel-art rules, asset requirements, environment readability, and visual polish.

Should care about:

- Visual identity.
- Player readability.
- Asset pipeline.
- Pixel-art style.
- Animation direction.
- Environment clarity.
- Combat readability.

Outputs:

- Asset direction notes.
- Art requirements.
- Visual hierarchy rules.
- Reference notes.
- Deferred art tasks.

## Release Manager

Purpose:

- Checks release readiness, completion criteria, blockers, and what must happen before release milestones.

Should care about:

- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`
- Completed sprint work.
- Blockers.
- Missing release criteria.

Outputs:

- Release readiness notes.
- Release tracker updates.
- Blocker list.
- Go/no-go recommendations.

## Git / Integration Operator

Purpose:

- Maintains branch hygiene, commit hygiene, staging separation, merges, pushes, and repo safety.

Should care about:

- Current branch.
- Git status.
- Untracked files.
- Commit separation.
- Push status.
- Merge safety.
- Avoiding mixed commits.

Outputs:

- Clean commits.
- Push confirmation.
- Merge plan.
- Branch cleanup notes.
- Repo safety checks.

## Product / Platform Strategist

Purpose:

- Connects AltarSky to GamerPal, branding, app positioning, platform strategy, user onboarding, monetization boundaries, and long-term product identity.

Should care about:

- GamerPal relationship.
- AltarSky app positioning.
- Branding.
- App store direction.
- Platform strategy.
- Long-term product ecosystem.

Outputs:

- Product strategy notes.
- Branding ideas.
- Platform integration plans.
- Future roadmap notes.

---

# Hat Switching Rule

The user should be able to say:

- "I am switching to Developer Hat."
- "Switch me to Project Manager Hat."
- "I want to wear Visionary Hat today."
- "Put me in Documentation Architect mode."

When a hat switch is detected, the AI should:

1. Identify the target hat.
2. Identify the previous hat if known.
3. Check whether the previous hat requires handoff or parking.
4. Run the target hat startup checklist.
5. Ask only the required immediate questions.
6. Open or reference the required docs.
7. Confirm the work mode before proceeding.

Hat switching should not happen blindly.

Some transitions require handoff.

Examples:

Developer to Visionary:

- Park active task state first.
- Capture current file/task.
- Then allow idea exploration.

Visionary to Developer:

- Filter ideas against current sprint scope.
- Select one actionable task or return to prior task.

Developer to Documentation Architect:

- Capture what changed.
- Identify affected docs.
- Decide update now vs deferred TODO.

Development Systems Architect to any other hat:

- Capture OS changes or OS TODOs before leaving the meta-layer.

---

# Assistant Guidance Protocol

The AI should follow the repo-based operating system.

The AI should not rely only on memory.

Before major action, the AI should:

1. Identify the likely hat/work mode.
2. Repeat back the interpreted task briefly.
3. Ask required routing or setup questions.
4. Follow the relevant workflow.
5. Avoid overloading the user with unnecessary branches.
6. Give one instruction at a time during active implementation unless the user asks for a full plan.
7. If the user asks for copy-paste content, provide one complete uninterrupted copy-paste block.
8. If the user is actively working, do not interrupt constantly for documentation.
9. At natural stopping points, remind the user to update docs now or add a deferred documentation TODO.
10. If the user starts discussing work that belongs to another hat, suggest parking it or switching hats.
11. If a session ends, offer a session log or documentation checkpoint.
12. If a sprint ends, run sprint closeout.

The AI should be able to say:

- "This sounds like Visionary Hat work. Do you want to switch hats or park it?"
- "This is outside the current Developer Hat scope. Add it to deferred ideas?"
- "This is OS friction. Capture it for Development Systems Architect review."
- "This is documentation debt. Add a TODO to current_sprint.md or update docs now?"
- "Before switching hats, we should park the current task."

---

# AI Continuous Improvement Check

The Developer Operating System should include a lightweight AI self-improvement loop.

When the AI reads or uses the high-level operating-system docs, it should briefly look for one possible improvement, friction point, unclear rule, repeated manual action, missing template, drift risk, or workflow optimization.

The AI should not derail the current task to solve the improvement immediately.

Instead, the AI should help the user park the improvement quickly for later review.

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

This loop exists to prevent system drift and continuously improve the workflow during every ai pass without interrupting active development.

# Blowout Mitigation / Idea-Catching System

A blowout is when a valuable idea, concern, or tangent appears while wearing a hat that should not act on it immediately.

The system should catch blowouts without losing them and without derailing current work.

Examples:

Developer Hat blowout:

- User gets a major future systems idea while coding.
- AI should say it sounds like Visionary or Planning work.
- User may switch hats or park it.
- Active coding task should not be lost.

Project Manager Hat blowout:

- User notices workflow friction.
- AI should capture it as OS improvement backlog.
- Do not rewrite workflow during project-management session unless switching to Development Systems Architect.

Visionary Hat blowout:

- User generates a feature idea that seems important.
- AI should capture it in planning or idea inbox.
- Project Manager later decides whether it enters roadmap/sprint.

Documentation Architect blowout:

- User notices many docs need restructuring.
- AI should capture a documentation refactor task.
- Avoid derailing if current task is a small doc fix.

The blowout system should eventually support different chats for different purposes.

If the user starts working in the wrong chat or wrong mode, the AI should gently route them:

- "This sounds like Conceptualization Hat work. Switch to that chat or park it here?"
- "This belongs in Documentation Architect mode. Do you want to switch hats?"
- "I will hold the current Developer task while you capture this idea."

---

# Project State Dimensions

The operating system must help the AI/user understand four project dimensions:

1. Identity
2. History
3. Now
4. Future

## Identity

What is AltarSky?

Possible source docs:

- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/planning/roadmap.md`
- `docs/release_tracker/release_roadmap.md`

## History

What has already happened?

Source docs:

- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`
- Release-specific devlogs

## Now

What are we doing right now?

Source docs:

- `docs/sprints/current_sprint.md`
- Active branch
- Current release tracker

## Future

What might happen later?

Source docs:

- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`
- Future idea inbox, if created later

---

# Scene Map Documentation

The Developer Operating System should eventually support scene map documentation for Godot-specific scene structure.

Scene map docs explain the visual/non-code structure of the project:

- Scene tree layout
- Important nodes
- Node responsibilities
- Attached scripts
- Exported variables
- Inspector settings
- Signal connections
- Scene dependencies
- Tuning values that are important to preserve

Scene map docs are different from system docs.

System docs explain why a system exists and how it behaves.

Scene map docs explain how the Godot scene is physically organized in the editor.

Possible future folder:

- `docs/scene_maps/`

Possible future docs:

- `docs/scene_maps/main_scene.md`
- `docs/scene_maps/ui_main.md`
- `docs/scene_maps/player_scene.md`
- `docs/scene_maps/sky_layer_system_scene.md`

Possible future template:

- `docs/00_ReadMeFirst/templates/scene_map_template.md`

This should be added after the first Developer Operating System control docs are created, unless scene/node confusion becomes an immediate blocker.
# Git Hygiene Rules

The Git / Integration Operator should enforce clean repo habits.

Rules:

- Confirm the real project path before acting.
- Check branch before major work.
- Check `git status` before staging.
- Do not use `git add .` when code/docs/assets should be separated.
- Stage docs separately from code when practical.
- Stage tuning separately from system rewrites when practical.
- Commit documentation structure separately from documentation content when useful.
- Commit code systems separately from scene tuning when useful.
- Push only after clean commits are confirmed.
- Verify clean status after committing.
- If folders or paths seem wrong, stop and investigate before committing.
- If there are duplicate repo folders, resolve path confusion before continuing.

Recent lesson:

- The project had two local folders:
  - `~/Projects/AltarskyGame`
  - `~/Projects/GamerPal/AltarskyGame`
- The real Godot project is:
  - `~/Projects/GamerPal/AltarskyGame`
- A symlink now points:
  - `~/Projects/AltarskyGame` → `~/Projects/GamerPal/AltarskyGame`

This should be preserved as a warning in future workflow docs if path confusion becomes relevant again.

---

# Execution Plan / Time Map

This section defines how we are building the Developer Operating System.

The system should be built top-down.

Do not try to perfect every lower-level doc before the scaffolding exists.

## Phase 0 — Stabilize Repo and Structure

Status: mostly complete.

Completed:

- Confirmed correct project path.
- Quarantined wrong duplicate folder.
- Added symlink to real Godot project.
- Reorganized docs into:
  - `docs/00_ReadMeFirst/`
  - `docs/01_devlogs/`
  - `docs/game_flow/`
  - `docs/planning/`
  - `docs/release_tracker/`
  - `docs/sprints/`
  - `docs/systems/`
- Fixed Markdown break in documentation guide.
- Split docs/code/tuning commits cleanly.
- Pushed clean branch.

Remaining:

- Verify all current docs use correct paths after final renames/splits.
- Keep working tree clean between major steps.

## Phase 1 — Capture Operating System Design

Status: active.

Goal:

- Create this design-notes file.
- Capture raw system design before splitting into final docs.

Output:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Success condition:

- The ideas from chat are captured externally in the repo.
- Hats, pyramid, workflow, AI protocol, blowout mitigation, templates, logs, and implementation plan are documented enough to guide final doc creation.

## Phase 2 — Finalize Top-Level Pyramid Names

Goal:

- Decide and implement final `00_ReadMeFirst/` control-doc names.

Planned final structure:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

Tasks:

- Rename existing `00_documentation_guide.md` to `01_documentation_guide.md`, if approved.
- Create `00_start_here.md`.
- Create `02_project_document_map.md`.
- Create `03_development_workflow.md`.
- Create `templates/`.
- Create `current_sprint_template.md`.

Important:

- Do not create these blindly.
- Use this design-notes file as the scaffold.
- Build one document at a time.
- Verify each document before moving to the next.

## Phase 3 — Build `00_start_here.md`

Goal:

- Create the front-door routing document.

It should include:

- Brief introduction.
- What this system is.
- Why it exists.
- Instruction to read the whole start document before diving deeper.
- First routing questions.
- Project onboarding fallback.
- Hat onboarding fallback.
- Documentation/workflow fallback paths.
- How to return to the start doc if lost.

Success condition:

- A user or AI can open this file and know what to do next without being overwhelmed.

## Phase 4 — Build `01_documentation_guide.md`

Goal:

- Convert the existing guide into a clean documentation rules file.

It should include:

- Folder structure.
- Naming rules.
- Maintenance note rules.
- No orphan docs rule.
- Template location.
- Brief mention of workflow docs.
- No excessive workflow detail.

Success condition:

- The guide explains where docs belong and how documentation stays connected.
- It does not try to be the whole workflow brain.

## Phase 5 — Build `02_project_document_map.md`

Goal:

- Create the document ecosystem map.

It should include:

- Project identity/history/now/future source docs.
- Document type map.
- Active document list.
- What feeds what.
- What each document is for.
- When each document is updated.
- Which templates apply.

Success condition:

- An AI or teammate can understand the project documentation ecosystem without reading every doc first.

## Phase 6 — Build `03_development_workflow.md`

Goal:

- Create the role-aware Developer Operating System.

It should include:

- Hat definitions.
- Hat onboarding.
- Hat startup checklists.
- Hat handoff rules.
- Session workflow.
- Idea capture.
- Blowout mitigation.
- Documentation deferral.
- Sprint lifecycle.
- Sprint closeout.
- Git hygiene.
- Assistant Guidance Protocol.
- System evolution process.

Success condition:

- The user can say "I am switching to X hat" and the AI knows what to ask/check next.

## Phase 7 — Build Sprint Template

Goal:

- Create `docs/00_ReadMeFirst/templates/current_sprint_template.md`.

It should include:

- Required sprint sections.
- Sprint closeout checklist.
- Deferred documentation section.
- Good ideas/not current scope section.
- Completed tasks section.
- Next sprint candidate section.

Success condition:

- `docs/sprints/current_sprint.md` can be reset from the template without rebuilding structure from memory.

## Phase 8 — Rebuild Current Sprint

Goal:

- Reorganize `docs/sprints/current_sprint.md` using the sprint template.

It should preserve:

- Current Sky Layer Manager sprint identity.
- Current active tasks.
- Completed debug console work.
- Completed documentation structure cleanup.
- Deferred Developer Operating System work.
- Remaining Sky Layer Manager tasks.
- Known blockers/risks.
- Documentation TODOs.

Success condition:

- Current sprint becomes a clean live work surface.
- Completed work is moved instead of deleted.
- Deferred docs and ideas are captured.

## Phase 9 — Recreate Player Soul Core Doc

Goal:

- Recreate `docs/systems/player_soul_core.md` in the correct repo.

It should include:

- Soul core as true hitbox.
- Player body as astral projection.
- Render hierarchy.
- Core and enemy projectile readability.
- Death sequence.
- Sanctuary return.
- Revival hook.
- Debug workflow.
- Pre-Alpha scope.
- Maintenance note with correct paths.

Success condition:

- The soul core system is documented in the correct repo and discoverable from the document guide/map.

## Phase 10 — Update Related Docs

Goal:

- Update related docs after player soul core and workflow system exist.

Likely affected docs:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`
- `docs/systems/player_controller.md`
- `docs/systems/projectile_system.md`
- `docs/systems/skyflow_director.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/sky_lighting_system.md`
- `docs/systems/ui_system.md`
- `docs/planning/roadmap.md`
- `docs/planning/sky_time_map.md`
- `docs/01_devlogs/project_milestones.md`
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`

Success condition:

- New systems are integrated into the document ecosystem.
- No orphan docs.
- No stale paths.
- Documentation maintenance notes align with final structure.

## Phase 11 — Test the AI Against the System

Goal:

- Confirm the system actually works before returning to game development.

Test prompts:

- "I am switching to Developer Hat."
- "I am switching to Visionary Hat."
- "Time to update docs."
- "Close out this sprint."
- "I have a good idea but I am coding."
- "I want to evolve the operating system."
- "Where does this note belong?"
- "Generate an end-of-session log."
- "What should I work on next?"

Success condition:

- AI routes correctly.
- AI asks the right warm-up questions.
- AI does not overrun the user.
- AI captures ideas without derailment.
- AI knows when to update docs vs defer.
- AI follows repo docs instead of relying only on memory.


## Phase 12 — Build Local Workflow Helper Tools

Goal:

- Add small local terminal tools that make the Developer Operating System faster and less painful to use.

Reason:

The operating system should not rely on vague instructions such as "update the devlog" or "document that later."

When possible, the AI should provide the user with fast, safe, copy-pasteable terminal commands or paste blocks that update the correct document or park the correct note.

This keeps the user moving quickly while still preserving project knowledge.

Possible helper tool location:

- `tools/docs/`

Possible helper scripts:

- `tools/docs/add_os_improvement.sh`
- `tools/docs/park_idea.sh`
- `tools/docs/add_doc_todo.sh`
- `tools/docs/add_blocker.sh`
- `tools/docs/add_completed_task.sh`
- `tools/docs/add_session_log.sh`

Initial manual command pattern:

```bash
cat <<'EOF' >> docs/sprints/current_sprint.md

## Developer OS Improvement Notes

- [ ] Improvement idea:
  - Source hat:
  - Reason:
  - Review as:

EOF
```

Rules:

- Do not use `sudo` for repo documentation updates.
- Prefer safe append commands before using destructive edit commands.
- Prefer `cat <<'EOF' >> file.md` for quick parking.
- Use scripts only after the document structure is stable.
- Always run `git diff -- docs` after scripted documentation updates.
- AI should give exact paste blocks or terminal commands when practical.
- AI should tell the user exactly where the command writes or where the block should be pasted.

Success condition:

- The user can park ideas, documentation TODOs, blockers, completed tasks, session logs, and Developer OS improvements quickly without manually searching through docs.
- The helper commands make the workflow faster instead of more complicated.
- The system is tested and improved before returning fully to game development.


## Phase 13 — Resume Game Development

Goal:

- Return to Sky Layer Manager / Pre-Alpha 0.1 work once the Developer Operating System works well enough.

Before resuming:

- Confirm current sprint is clean.
- Confirm active hat is Developer or Scrum Master.
- Confirm next task is clear.
- Confirm docs have a deferred update path.
- Confirm branch is clean.


# System Evolution Rule

The Developer Operating System is alive.

It is expected to evolve.

When the system itself needs to change:

1. Switch to Development Systems Architect Hat.
2. Capture the reason for the change.
3. Identify which `00_ReadMeFirst/` docs are affected.
4. Update high-level rules first.
5. Update templates if needed.
6. Update working docs only after the high-level rule is stable.
7. Preserve prior reasoning in design notes or devlogs if the change is significant.
8. Test the AI/user flow after the change.

Do not silently mutate the operating system from another hat.

Other hats may generate OS improvement notes.

Only Development Systems Architect should approve and integrate operating-system changes.

---

# Open Questions

These need decisions before or during final doc creation:

- Should `docs/00_ReadMeFirst/01_documentation_guide.md` be renamed to `docs/00_ReadMeFirst/01_documentation_guide.md`?
- Should this design-notes file remain after final docs exist, or should it be archived as a devlog/design-history document?
- Should idea capture start as a section inside `current_sprint.md` or as a separate `docs/planning/idea_inbox.md`?
- Should the first template folder include only `current_sprint_template.md`, or also `session_log_template.md`?
- Should hat-specific checklists live entirely in `03_development_workflow.md`, or should very large hats eventually get their own subdocuments?
- Should team onboarding be a future doc once teammates begin using the system?
- How much of the Assistant Guidance Protocol should live in `00_start_here.md` versus `03_development_workflow.md`?
- Should session logs be pasted into `current_sprint.md` first, then converted to devlogs at sprint closeout?
- What is the minimum set of tests the AI must pass before game development resumes?

---

# Immediate Next Steps

1. Save this design scaffold.
2. Run `git status --short`.
3. Review this file for missing major ideas.
4. Decide whether to commit this scaffold as a temporary design note.
5. If committed, create final top-level docs in this order:
   - `00_start_here.md`
   - `01_documentation_guide.md`
   - `02_project_document_map.md`
   - `03_development_workflow.md`
   - `templates/current_sprint_template.md`
6. Rebuild `current_sprint.md`.
7. Recreate `player_soul_core.md`.
8. Test the AI against the operating system.

---

# Final Design Intent

The goal is to build a small factory for developing AltarSky.

The factory should train the user, the AI, and eventually teammates to enter the correct role, follow the correct process, update the correct docs, and preserve project knowledge.

The system should be powerful enough to grow into a behemoth, but structured enough that the AI does not choke on it.

Top-level docs should route.

Mid-level docs should explain.

Working docs should remind.

Templates should reset.

Sprint docs should move work.

Devlogs should preserve history.

Planning docs should hold future.

System docs should explain behavior.

Game-flow docs should explain player state.

Release trackers should define completion.

The repo should remain the source of truth.

The AI should follow the repo.

- Should the Developer Operating System include a future `docs/00_ReadMeFirst/04_new_maintainer_onboarding.md` document or template for onboarding teammates, future maintainers, and new AI sessions into the hat/workflow system?
- Should the Developer Operating System include a future `docs/scene_maps/` folder for documenting Godot scene trees, node structure, inspector settings, exported variables, signal connections, and scene-specific tuning values?
