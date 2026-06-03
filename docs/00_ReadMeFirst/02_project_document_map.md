# Project Document Map

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/00_start_here.md` — update if project onboarding, document routing, or source-of-truth paths change.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update if folder purposes, documentation rules, maintenance-note rules, template rules, or document categories change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — update after it is created if workflow, hats, sprint lifecycle, or document-flow rules change.
> - `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md` — update while the Developer Operating System is still being designed.
> - `docs/sprints/current_sprint.md` — update if this map changes active sprint workflow, documentation TODOs, or Developer Operating System work.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if release scope, completion criteria, or Pre-Alpha 0.1 source-of-truth paths change.
> - `docs/planning/roadmap.md` — update if current direction, future planning, or roadmap source-of-truth paths change.
>
> This document maps the AltarSky project documentation ecosystem. It explains what the project is, where project state lives, what each document type is for, and how documents feed into one another.

---

# Purpose

This document explains how the AltarSky documentation system fits together.

It is not the full documentation rulebook.

It is not the full development workflow.

It is the project/document ecosystem map.

Use this document to understand:

- What AltarSky is.
- Where project identity lives.
- Where project history lives.
- Where current work lives.
- Where future plans live.
- What document types exist.
- What actual documents currently exist.
- What each document is for.
- What feeds into what.
- Which document is the source of truth for a specific kind of information.

If you get lost before using this map, start with:

- `docs/00_ReadMeFirst/00_start_here.md`

If you need documentation rules, use:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

If you need workflow/hats/session process, use:

- `docs/00_ReadMeFirst/03_development_workflow.md`

If that workflow doc does not exist yet, use:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

---

# AltarSky Project Identity

AltarSky is a Godot mobile portrait vertical sky-world shmup / bullet-hell prototype.

The current release target is:

- Pre-Alpha 0.1

The current active branch is:

- `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`

Current game-development focus:

- Sky Layer Manager Depth & Lighting
- Layered sky/cloud/island world
- Atmospheric depth
- Dynamic spawning and recycling
- Player corridor readability
- Sky-world visual polish

Current meta-development focus:

- Building the AltarSky Developer Operating System before returning to game implementation

Important project identity notes:

- AltarSky should feel like a layered moving sky world, not a flat background.
- The player flies forward over islands below.
- The player should remain visually readable and central.
- The player soul core is the true hitbox and primary gameplay identity.
- The sky/environment should support bullet-hell readability.
- Pre-Alpha 0.1 should demonstrate the core vision through a minimal playable loop.

---

# Project State Model

The project state is understood through four dimensions:

1. Identity
2. History
3. Now
4. Future

## Identity

Identity answers:

- What is AltarSky?
- What is the current release target?
- What is the game trying to become?
- What are the core design pillars?

Primary source docs:

- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/planning/roadmap.md`
- `docs/release_tracker/release_roadmap.md`
- `docs/release_tracker/pre_alpha_0_1.md`

## History

History answers:

- What has already happened?
- What systems were completed?
- What major milestones were reached?
- What problems were solved?
- What decisions were made in the past?

Primary source docs:

- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`
- Release-specific devlogs under `docs/01_devlogs/`

## Now

Now answers:

- What are we actively working on?
- What branch are we on?
- What sprint is active?
- What tasks are active?
- What is blocked?
- What should happen next?

Primary source docs:

- `docs/sprints/current_sprint.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- Current Git branch and working tree state

## Future

Future answers:

- What might happen later?
- What systems are planned but not active?
- What ideas are shelved?
- What belongs in later releases?
- What should not derail the current sprint?

Primary source docs:

- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`
- Future idea inbox or Developer OS improvement backlog, if created later

---

# Document Types / High-Level Rules

This section defines document categories.

It explains what each kind of document is for, when it is updated, and what it feeds into.

---

## Start-Here Document

Current document:

- `docs/00_ReadMeFirst/00_start_here.md`

Purpose:

- Front door to the AltarSky Developer Operating System.
- Explains how to begin.
- Asks first routing questions.
- Routes the user/AI into project onboarding, hat onboarding, documentation rules, active work, closeout, or system evolution.

Updated when:

- Top-level routing changes.
- Hat onboarding path changes.
- Project onboarding path changes.
- AI first-response expectations change.
- New core control docs are added.

Feeds into:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/sprints/current_sprint.md`

Fed by:

- Changes to the Developer Operating System.
- Changes to hats/work modes.
- Changes to source-of-truth routing.

---

## Documentation Guide

Current document:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

Purpose:

- Documentation rules.
- Folder glossary.
- Naming rules.
- Maintenance-note rules.
- No orphan docs rule.
- Documentation creation/update rules.

Updated when:

- Folder structure changes.
- Documentation naming rules change.
- Maintenance-note requirements change.
- New document categories are added.
- Template rules change.
- Cross-document update expectations change.

Feeds into:

- Every documentation file.
- Maintenance notes.
- New doc creation.
- Documentation updates.
- Documentation Architect work.

Fed by:

- Documentation architecture changes.
- Developer Operating System changes.
- Recurring documentation friction.

---

## Project Document Map

Current document:

- `docs/00_ReadMeFirst/02_project_document_map.md`

Purpose:

- Explains what docs exist.
- Explains what each doc does.
- Explains where project identity/history/now/future live.
- Explains document types and document flow.
- Helps AI, user, or future teammate understand the project ecosystem.

Updated when:

- New major docs are created.
- Document responsibilities change.
- Project-state source docs change.
- New folders or document types are added.
- Current project identity/history/now/future routing changes.

Feeds into:

- Project onboarding.
- AI context loading.
- Documentation Architect work.
- Project Manager work.
- New maintainer onboarding.

Fed by:

- Changes to the documentation tree.
- Changes to project workflow.
- Changes to project state sources.

---

## Development Workflow

Planned document:

- `docs/00_ReadMeFirst/03_development_workflow.md`

Temporary source until created:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Purpose:

- Defines hats/work modes.
- Defines how work sessions start.
- Defines how hat switching works.
- Defines how ideas are parked.
- Defines how session closeout works.
- Defines how sprint closeout works.
- Defines AI guidance rules.
- Defines blowout mitigation.
- Defines git hygiene.
- Defines how the operating system evolves.

Updated when:

- Hats change.
- Hat switching changes.
- Workflow process changes.
- Session/sprint closeout changes.
- AI guidance changes.
- Blowout mitigation changes.
- Local helper tool process changes.
- System evolution process changes.

Feeds into:

- `docs/sprints/current_sprint.md`
- Sprint template
- Session logs
- AI behavior
- Project management process
- Development process
- Documentation process

Fed by:

- Development Systems Architect work.
- Process friction notes.
- AI continuous improvement notes.
- Sprint closeout lessons.

---

## Design Scaffold

Current document:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Purpose:

- Temporary design scaffold for the Developer Operating System.
- Captures raw architecture before final docs are created or split.
- Preserves reasoning while the system is being built.

Updated when:

- The Developer Operating System is still in design mode.
- New high-level concepts are discovered before final docs exist.
- Phase plan changes.
- Open questions are added.

Feeds into:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- Templates
- Current sprint workflow updates

Fed by:

- Development Systems Architect discussions.
- Operating-system design sessions.
- AI/user workflow experiments.

Future handling:

- Once final control docs exist, this file should either remain as design history, be archived, or be replaced by the finalized docs.
- It should not remain the primary workflow source forever.

---

## Templates

Planned folder:

- `docs/00_ReadMeFirst/templates/`

Initial planned template:

- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

Purpose:

- Provide reusable blank structures.
- Prevent sprint/docs from being rebuilt from memory.
- Keep resets consistent.

Updated when:

- Required document structure changes.
- Sprint process changes.
- Repeated workflows need standardization.
- New repeated doc types need reusable structures.

Feeds into:

- `docs/sprints/current_sprint.md`
- Session logs
- Future devlogs
- Future system docs
- Future game-flow docs

Fed by:

- Workflow changes.
- Documentation Architect work.
- Sprint closeout lessons.
- Repeated manual documentation actions.

Rule:

- Do not overbuild templates too early.
- Start with `current_sprint_template.md`.
- Add more templates when repetition proves they are needed.

---

## Sprint Document

Current document:

- `docs/sprints/current_sprint.md`

Purpose:

- Live active sprint workspace.
- Tracks current sprint identity, goals, active tasks, completed work, decisions, blockers, deferred ideas, documentation TODOs, and closeout notes.

Updated when:

- Sprint starts.
- Tasks are added.
- Tasks are completed.
- Decisions are made.
- Blockers are discovered.
- Documentation TODOs are deferred.
- Ideas need to be parked.
- Session logs need temporary placement.
- Sprint closes.

Feeds into:

- `docs/01_devlogs/`
- `docs/01_devlogs/project_milestones.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/systems/*.md`
- `docs/game_flow/*.md`

Fed by:

- Current sprint planning.
- Project Manager decisions.
- Scrum Master process.
- Developer task completion.
- QA findings.
- Documentation Architect notes.
- Visionary deferred ideas.
- AI continuous improvement notes.

Closeout behavior:

- Completed work is moved into devlogs/history/milestones.
- Release-impacting work updates release tracker.
- System behavior changes update system docs.
- Player-flow changes update game-flow docs.
- Future ideas move to planning.
- Unfinished work moves to the next sprint.
- The sprint doc resets from `current_sprint_template.md` once the template exists.

---

## Release Tracker

Current docs:

- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`

Purpose:

- Defines what must be finished before a release is complete.
- Tracks release goals, requirements, blockers, and completion status.

Updated when:

- Release scope changes.
- A release requirement is completed.
- A blocker appears or is resolved.
- A sprint completes release-impacting work.
- Release milestone direction changes.

Feeds into:

- Sprint planning.
- Project Manager decisions.
- Release Manager checks.
- Roadmap updates.
- Go/no-go decisions.

Fed by:

- Current sprint completed work.
- QA validation.
- System status.
- Project Manager scope decisions.
- Release Manager review.

---

## Roadmap / Planning Docs

Current docs:

- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`

Purpose:

- Tracks future direction.
- Holds ideas that are not current sprint scope.
- Preserves shelved systems.
- Keeps long-term plans from derailing active work.

Updated when:

- Project direction changes.
- Future ideas survive review.
- Systems are deferred.
- A shelved system becomes active.
- Roadmap priorities change.
- Time-of-day or sky-cycle planning changes.

Feeds into:

- Project Manager work.
- Sprint planning.
- Release roadmap.
- Future system docs.
- Visionary work.

Fed by:

- Visionary / Concept Designer ideas.
- Sprint closeout.
- Project Manager decisions.
- Developer deferred ideas.
- Release planning.

---

## System Docs

Current docs include:

- `docs/systems/auth_system.md`
- `docs/systems/debug_console.md`
- `docs/systems/main_scene_controller.md`
- `docs/systems/player_controller.md`
- `docs/systems/projectile_system.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/skyflow_director.md`
- `docs/systems/sky_lighting_system.md`
- `docs/systems/ui_system.md`

Planned doc:

- `docs/systems/player_soul_core.md`

Purpose:

- Explain how major systems work.
- Explain why systems exist.
- Explain how systems fit into AltarSky.

Updated when:

- System behavior changes.
- System architecture changes.
- New system responsibilities are added.
- Existing responsibilities are removed.
- A system becomes active.
- A system is split or merged.
- A system decision is finalized.

Feeds into:

- Developer work.
- QA testing.
- Release tracker.
- Sprint planning.
- Documentation Architect review.
- Project onboarding.

Fed by:

- Code changes.
- Scene changes.
- Sprint completed work.
- Design decisions.
- Debugging discoveries.
- Refactors.

Rule:

- Do not create duplicate system docs for the same system.
- Update existing system docs when the system changes.
- If a system doc becomes too broad, split it intentionally.

---

## Game-Flow Docs

Current docs:

- `docs/game_flow/boot_flow.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/game_state_map.md`
- `docs/game_flow/home.md`
- `docs/game_flow/inventory.md`
- `docs/game_flow/main_menu.md`
- `docs/game_flow/paused.md`

Purpose:

- Explain how the player moves through screens, states, flows, and transitions.

Updated when:

- Player flow changes.
- Screen/state transitions change.
- Main menu flow changes.
- Gameplay loop changes.
- Pause behavior changes.
- Home/sanctuary behavior changes.
- Inventory flow changes.
- Death return flow changes.
- Between-round flow changes.

Feeds into:

- UI work.
- Main scene work.
- Release tracker.
- System docs.
- QA testing.
- Project onboarding.

Fed by:

- Design decisions.
- Gameplay system changes.
- UI changes.
- Sprint completed work.
- Player experience decisions.

---

## Devlogs

Current docs:

- `docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md`
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`

Purpose:

- Preserve what happened.
- Record completed work.
- Record debugging discoveries.
- Record historical milestones.
- Record major decisions and outcomes.

Updated when:

- Significant work is completed.
- A sprint closes.
- Major investigation finishes.
- Major system refactor completes.
- A milestone is reached.
- Historical context needs preservation.

Feeds into:

- Project onboarding.
- Project milestones.
- Release history.
- Future debugging.
- Project Manager review.
- New maintainer onboarding.

Fed by:

- Sprint closeout.
- Session logs.
- Completed tasks.
- QA investigations.
- Debugging reports.
- Major commits.

Rule:

- Devlogs explain what happened.
- System docs explain how systems work now.
- Do not use devlogs as the only source of current system truth.

---

## Scene Map Docs

Planned folder:

- `docs/scene_maps/`

Possible future docs:

- `docs/scene_maps/main_scene.md`
- `docs/scene_maps/ui_main.md`
- `docs/scene_maps/player_scene.md`
- `docs/scene_maps/sky_layer_system_scene.md`

Purpose:

- Document Godot scene tree structure.
- Document important nodes.
- Document attached scripts.
- Document exported variables.
- Document inspector settings.
- Document signal connections.
- Document scene dependencies.
- Document tuning values that matter.

Updated when:

- Scene tree structure changes significantly.
- Important nodes are added, removed, or renamed.
- Exported inspector variables change meaning.
- Signal connections change.
- Scene responsibilities change.
- Scene-specific tuning becomes important to preserve.

Feeds into:

- Developer work.
- QA testing.
- Documentation Architect review.
- New maintainer onboarding.
- System docs.

Fed by:

- Scene edits.
- Godot editor changes.
- Inspector tuning.
- UI layout changes.
- Sky layer tuning.
- Player scene changes.

Rule:

- Scene map docs explain how Godot scenes are physically organized.
- System docs explain why a system exists and how it behaves.
- Scene maps and system docs may cross-reference each other.

Status:

- Planned.
- Do not create this folder until the core Developer Operating System docs are stable, unless scene/node confusion becomes an immediate blocker.

---

## New Maintainer Onboarding

Potential future doc:

- `docs/00_ReadMeFirst/04_new_maintainer_onboarding.md`

Possible future template:

- `docs/00_ReadMeFirst/templates/new_maintainer_onboarding_template.md`

Purpose:

- Help future teammates, maintainers, or new AI sessions enter the project correctly.
- Explain how to read the operating system.
- Explain how to choose a hat.
- Explain how to find current work.
- Explain how not to break the documentation/workflow system.
- Explain basic git and doc expectations.

Updated when:

- Teammates begin using the system.
- Onboarding process changes.
- Hat system changes.
- New maintainer expectations change.
- Required setup steps change.

Feeds into:

- Team onboarding.
- AI onboarding.
- Project consistency.
- Workflow adoption.

Fed by:

- Development Systems Architect work.
- Documentation Architect work.
- Team friction.
- New maintainer feedback.

Status:

- Planned.
- For now, onboarding behavior should be partially handled by `00_start_here.md`.

---

# Active Project Documents

This section lists the actual documents that currently exist or are planned.

---

## `docs/00_ReadMeFirst/00_start_here.md`

Type:

- Start-here document

Purpose:

- Front-door router for the Developer Operating System.

Updated when:

- Top-level routing changes.
- Project onboarding path changes.
- Hat onboarding path changes.
- AI first-response protocol changes.

Feeds into:

- Documentation guide
- Project document map
- Development workflow
- Current sprint

Notes:

- Keep short and useful.
- Do not turn into the full rulebook.

---

## `docs/00_ReadMeFirst/01_documentation_guide.md`

Type:

- Documentation guide

Purpose:

- Documentation rules, folder structure, maintenance notes, no-orphan-doc rules, and naming rules.

Updated when:

- Documentation rules change.
- Folder structure changes.
- Template rules change.
- Cross-document rules change.

Feeds into:

- Every doc.

Notes:

- This is the documentation constitution.
- Keep workflow detail out of this doc when possible.

---

## `docs/00_ReadMeFirst/02_project_document_map.md`

Type:

- Project document map

Purpose:

- Map project state, document categories, active docs, and document relationships.

Updated when:

- Docs are added, removed, renamed, or re-scoped.
- Project-state source docs change.

Feeds into:

- Project onboarding.
- AI context loading.
- Documentation Architect work.
- Project Manager work.

Notes:

- This document should stay accurate as the docs evolve.

---

## `docs/00_ReadMeFirst/03_development_workflow.md`

Type:

- Development workflow

Status:

- Planned

Purpose:

- Define hats, workflows, session flow, sprint flow, idea capture, blowout mitigation, AI guidance, and system evolution.

Feeds into:

- Daily work.
- Sprint operation.
- AI behavior.
- Session closeout.
- Hat switching.

Notes:

- Until this exists, use `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`.

---

## `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Type:

- Temporary design scaffold

Purpose:

- Capture the design of the Developer Operating System before final docs are complete.

Updated when:

- New operating-system design ideas appear before they have a final home.

Feeds into:

- `00_start_here.md`
- `01_documentation_guide.md`
- `02_project_document_map.md`
- `03_development_workflow.md`
- Templates

Notes:

- This should not remain the primary source forever.
- It may remain as design history after final docs exist.

---

## `docs/sprints/current_sprint.md`

Type:

- Current sprint document

Purpose:

- Active sprint workspace.

Updated when:

- Work is planned, completed, blocked, deferred, or closed out.

Feeds into:

- Devlogs
- Milestones
- Release tracker
- System docs
- Game-flow docs
- Planning docs

Notes:

- Do not delete completed work.
- Move completed work into the Completed section once the sprint template exists.
- Closeout should preserve sprint knowledge before reset.

---

## `docs/release_tracker/pre_alpha_0_1.md`

Type:

- Release tracker

Purpose:

- Track Pre-Alpha 0.1 requirements and completion state.

Updated when:

- Pre-Alpha 0.1 scope or completion changes.

Feeds into:

- Sprint planning
- Release Manager review
- Project Manager decisions

Notes:

- This is the main release-readiness doc for the current release.

---

## `docs/release_tracker/release_roadmap.md`

Type:

- Release roadmap

Purpose:

- Define planned release milestones.

Updated when:

- Release strategy changes.

Feeds into:

- Project Manager work
- Roadmap
- Sprint planning

---

## `docs/planning/roadmap.md`

Type:

- Roadmap

Purpose:

- Track current and near-term development direction.

Updated when:

- Project focus, branch target, or major next steps change.

Feeds into:

- Sprint planning
- Project Manager work
- Future system planning

Notes:

- This doc should be reviewed for stale branch/focus references.

---

## `docs/planning/shelved_future_documentation.md`

Type:

- Shelved future systems list

Purpose:

- Preserve future systems without turning them into active scope.

Updated when:

- New future system ideas are captured.
- Shelved systems become active.
- Future ideas are removed, merged, or clarified.

Feeds into:

- Visionary work
- Planning
- Roadmap

---

## `docs/planning/sky_time_map.md`

Type:

- Planning doc

Purpose:

- Planned source for sky time-of-day, lighting, cycle, and sky-related time rules.

Status:

- Placeholder / needs content

Updated when:

- Sky time, lighting cycle, biome/time, or day/night design changes.

Feeds into:

- Sky Lighting System
- Sky Layer Manager
- Future biome/time systems

---

## `docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md`

Type:

- Devlog

Purpose:

- Record the debug console/logger overhaul and performance investigation.

Updated when:

- Historical correction is needed.

Feeds into:

- Pre-Alpha 0.1 history
- Project milestones
- Debug Console System doc
- UI System doc

---

## `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`

Type:

- Release history

Purpose:

- Record major Pre-Alpha 0.1 development phases.

Updated when:

- Major completed work should be preserved in release history.

Feeds into:

- Project onboarding
- Project milestones
- Future retrospectives

---

## `docs/01_devlogs/project_milestones.md`

Type:

- Project milestone timeline

Purpose:

- Track major project milestones.

Updated when:

- Major milestone is completed.
- Significant historical checkpoint is reached.

Feeds into:

- Project onboarding
- Project Manager review
- Future retrospectives

---

# System Document Index

Current system docs:

- `docs/systems/auth_system.md`
- `docs/systems/debug_console.md`
- `docs/systems/main_scene_controller.md`
- `docs/systems/player_controller.md`
- `docs/systems/projectile_system.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/skyflow_director.md`
- `docs/systems/sky_lighting_system.md`
- `docs/systems/ui_system.md`

Planned system docs:

- `docs/systems/player_soul_core.md`

System docs should be updated when the behavior, architecture, or responsibilities of a system change.

---

# Game Flow Document Index

Current game-flow docs:

- `docs/game_flow/boot_flow.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/game_state_map.md`
- `docs/game_flow/home.md`
- `docs/game_flow/inventory.md`
- `docs/game_flow/main_menu.md`
- `docs/game_flow/paused.md`

Game-flow docs should be updated when player state, screen transitions, or gameplay flow changes.

---

# Known Documentation Gaps

Current known gaps:

- `docs/00_ReadMeFirst/03_development_workflow.md` does not exist yet.
- `docs/00_ReadMeFirst/templates/current_sprint_template.md` does not exist yet.
- `docs/systems/player_soul_core.md` needs to be recreated in the correct repo.
- Several `docs/game_flow/` docs are placeholders.
- `docs/planning/sky_time_map.md` is a placeholder.
- `docs/systems/sky_depth_system.md` is a placeholder.
- `docs/systems/skyflow_director.md` is a placeholder.
- `docs/planning/roadmap.md` may contain stale branch/focus references.
- Future `docs/scene_maps/` may be needed for Godot scene trees, nodes, inspector settings, and signal wiring.
- Future new maintainer onboarding may be needed once teammates begin using the system.

---

# Update Flow Summary

When something happens, route it like this:

- What happened during development?
  - Update `docs/01_devlogs/`.

- What are we working on now?
  - Update `docs/sprints/current_sprint.md`.

- What must be finished before release?
  - Update `docs/release_tracker/`.

- What might happen later?
  - Update `docs/planning/`.

- How does a system work?
  - Update `docs/systems/`.

- How does the player move through screens/states?
  - Update `docs/game_flow/`.

- How is a Godot scene physically organized?
  - Future update to `docs/scene_maps/`.

- How should docs be organized?
  - Update `docs/00_ReadMeFirst/01_documentation_guide.md`.

- How do docs relate?
  - Update `docs/00_ReadMeFirst/02_project_document_map.md`.

- How do we work?
  - Update `docs/00_ReadMeFirst/03_development_workflow.md`.

- How should the operating system evolve?
  - Use Development Systems Architect Hat and update `00_ReadMeFirst/` docs.

---

# Final Rule

This map should help the user, AI, and future maintainers understand the project without needing to read every file first.

It should stay accurate.

If a new major doc is created, renamed, removed, or re-scoped, update this map.

No orphan docs.
