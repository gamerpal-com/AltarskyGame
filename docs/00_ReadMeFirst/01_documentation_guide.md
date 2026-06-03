# Documentation Guide

> Documentation maintenance note:
> If this document is updated, also review and update:
>
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — this file; keep the documentation rules accurate.
> - `docs/sprints/current_sprint.md` — update if documentation rules affect current sprint workflow or required documentation tasks.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if documentation requirements affect Pre-Alpha 0.1 completion criteria.
> - Any newly created document — every new document must include its own `Documentation maintenance note`.
>
> Every new documentation file must be added to this guide or otherwise made discoverable from the documentation structure. Do not create orphaned docs.

## Purpose

This file explains where AltarSky project information belongs.

Use it when deciding which document to create or update.

This file is the read-first documentation guide for AltarSky.

---

## Core Rule

Code comments explain:

- What the code does
- How the code works

Documentation explains:

- Why the system exists
- Why it is designed that way
- How it fits into AltarSky

---

## Documentation Maintenance Rule

AltarSky documentation must be maintained as a connected system, not as isolated files.

Every new documentation file must include a `Documentation maintenance note` near the top of the document.

That note must explicitly list the related documents that should be reviewed or updated when that document changes.

Every new documentation file must also be made discoverable from this documentation guide or the relevant documentation index/section.

Do not create hidden or orphaned documentation files.

When creating or updating documentation:

1. Decide what question the document answers.
2. Put it in the matching folder.
3. Add a `Documentation maintenance note` near the top of the document.
4. Explicitly list related documents that may need updates when this document changes.
5. Update affected related documents in the same commit when practical.
6. If a related update must be deferred, leave a clear TODO explaining why.
7. Make sure the new or changed document is discoverable from this guide or the relevant folder/index.
8. Do not create duplicate docs for the same system unless it is truly a separate system.

---

## Required Maintenance Note Template

Use this format near the top of every new major documentation file:

```md
> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/example/path.md` — explain when this related document should be updated.
> - `docs/example/other_path.md` — explain when this related document should be updated.
>
> Do not update this document in isolation when the change affects other systems. Update the related docs in the same commit, or leave a clear TODO explaining why the related update is deferred.
```

The maintenance note should be specific.

Avoid vague references such as:

```text
the documentation guide
the sprint doc
the release tracker
related docs
```

Prefer exact paths such as:

```text
docs/00_ReadMeFirst/01_documentation_guide.md
docs/sprints/current_sprint.md
docs/release_tracker/pre_alpha_0_1.md
docs/systems/skyflow_director.md
```

---

## Sprint Closeout Rule

`docs/sprints/current_sprint.md` is the active sprint workspace.

Do not delete completed sprint information.

At the end of each sprint:

1. Review `docs/sprints/current_sprint.md`.
2. Move completed sprint history, decisions, resolved blockers, and important notes into the appropriate archive or permanent documentation.
3. Convert major completed work into a devlog under `docs/01_devlogs/`.
4. Move unfinished work into the next sprint or a planning document.
5. Move deferred documentation items into the correct docs or keep them as explicit TODOs.
6. Reset `docs/sprints/current_sprint.md` for the next active sprint.

Sprint information should be preserved, not erased.

Recommended sprint closeout destinations:

- Completed work and session history: `docs/01_devlogs/pre_alpha_0_1/`
- Major milestones: `docs/01_devlogs/project_milestones.md`
- Release completion status: `docs/release_tracker/pre_alpha_0_1.md`
- Unfinished active work: next reset of `docs/sprints/current_sprint.md`
- Future ideas: `docs/planning/`
- Player/system behavior changes: related `docs/systems/` or `docs/game_flow/` docs

---

## Documentation Folders

### `00_ReadMeFirst/`

Where start-here documentation belongs.

Use for:

- Documentation guide
- Project documentation rules
- Development workflow rules
- How to read the docs
- Naming conventions
- Documentation maintenance rules

This folder should stay small.

Current docs:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

This folder answers:

```text
How should I use and maintain the docs?
```

---

### `01_devlogs/`

What happened during development.

Use for:

- Session summaries
- Completed work
- Fixes
- Discoveries
- Performance investigations
- Refactors
- Debugging notes
- Important design checkpoints

Devlogs may be grouped by release.

Example:

```text
docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md
```

Current docs include:

- `docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md`
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`

Devlogs answer:

```text
What happened?
```

---

### `release_tracker/`

What must be finished before a version is complete.

Use for:

- Pre-Alpha 0.1 requirements
- Pre-Alpha 0.2 requirements
- Release checklists
- Completion criteria
- Blockers for a release

Current docs:

- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`

Release tracker docs answer:

```text
What is required before this release is done?
```

---

### `sprints/`

What we are working on right now.

Use for:

- Active branch notes
- Current goals
- Current blockers
- Immediate next steps
- Feature sprint scope
- Completed work during the active sprint
- Deferred documentation TODOs
- Sprint closeout notes

Current docs:

- `docs/sprints/current_sprint.md`

Sprint docs answer:

```text
What are we actively building right now?
```

---

### `systems/`

Why each major system exists and how it fits into the game.

Use for systems like:

- Skyflow Director
- Sky Depth System
- Sky Lighting
- Player Controller
- Player Soul Core
- Projectile System
- Auth
- UI
- Debug Console
- Logger
- Inventory
- Pets

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

System docs answer:

```text
How does this system work now?
Why is it designed this way?
How does it fit into AltarSky?
```

If a system changes significantly, update the existing system doc.

Do not create a duplicate system doc unless it is truly a separate system.

---

### `planning/`

What may be built later.

Use for:

- Roadmaps
- Shelved systems
- MVP scope
- Future ideas
- Design possibilities
- Long-term feature notes
- Ideas that are good but not current sprint scope

Current docs:

- `docs/planning/roadmap.md`
- `docs/planning/shelved_future_documentation.md`
- `docs/planning/sky_time_map.md`

Planning docs answer:

```text
What might happen later?
```

---

### `game_flow/`

How the player moves through the game.

Use for:

- Boot flow
- Menus
- Gameplay state
- Pause state
- Inventory flow
- Home / sanctuary flow
- Return-home flow
- Between-round flow
- Death return flow
- Screen transitions

Current docs:

- `docs/game_flow/boot_flow.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/game_state_map.md`
- `docs/game_flow/home.md`
- `docs/game_flow/inventory.md`
- `docs/game_flow/main_menu.md`
- `docs/game_flow/paused.md`

Game flow docs answer:

```text
How does the player move through screens and states?
```

---

## Simple Rule

If it says what happened, put it in `01_devlogs/`.

If it says what must be finished, put it in `release_tracker/`.

If it says what we are building now, put it in `sprints/`.

If it says why a system exists or how it works, put it in `systems/`.

If it says what might happen later, put it in `planning/`.

If it says how the player moves through screens or states, put it in `game_flow/`.

If it explains how to use or maintain the docs, put it in `00_ReadMeFirst/`.

---

## Devlog vs System Doc

Some work belongs in two places.

Example:

A debugger overhaul belongs in:

```text
docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md
docs/systems/debug_console.md
```

The devlog explains:

```text
What happened during development.
What problem was discovered.
What was changed.
What the result was.
```

The system doc explains:

```text
How the debugger works now.
Why it is designed that way.
How it should be used later.
```

Do not put the full system explanation only in the devlog.

Do not put session history only in the system doc.

---

## Cross-Document Update Examples

### New System Document

When creating a new system document, also check:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/sprints/current_sprint.md`
- Related system docs
- Related game-flow docs
- Related planning docs

Example:

If `docs/systems/player_soul_core.md` is created or updated, review:

- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/sprints/current_sprint.md`
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

---

### New Devlog

When creating a new devlog, also check:

- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`
- `docs/sprints/current_sprint.md`
- The related system doc
- The related release tracker

---

### Release Scope Change

When release scope changes, also check:

- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/release_tracker/release_roadmap.md`
- `docs/sprints/current_sprint.md`
- `docs/planning/roadmap.md`
- Related system docs

---

### Game Flow Change

When player flow changes, also check:

- `docs/game_flow/game_state_map.md`
- The specific affected `docs/game_flow/` file
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/sprints/current_sprint.md`
- Related system docs

---

## Instructions

When adding new documentation:

1. Decide what question the document answers.
2. Put it in the matching folder.
3. Keep the document focused.
4. Add a `Documentation maintenance note` near the top.
5. List exact related document paths inside the maintenance note.
6. Do not mix devlogs, sprint notes, release requirements, and system explanations in one file.
7. If a document starts answering too many questions, split it into separate documents.
8. If an existing system doc already exists, update it instead of creating a duplicate.
9. If work happened during a specific release cycle, place the devlog inside that release's devlog folder.
10. Make sure the document is discoverable from this guide or the relevant index.
11. Update related docs in the same commit when practical.
12. Leave a clear TODO if a related update must be deferred.

Before updating docs, ask:

- Is this about what happened?
- Is this about what we are building now?
- Is this about what must be finished before release?
- Is this about why a system exists?
- Is this about how a system works now?
- Is this about future plans?
- Is this about player flow?
- Is this about how documentation should be organized?
- Which other docs become stale if this changes?

Use the answer to choose the folder and update related docs.

---

## Naming

Use lowercase filenames.

Use underscores instead of spaces.

Good:

```text
sky_layer_manager.md
debugger_overhaul_2026-06-01.md
pre_alpha_0_1.md
```

Bad:

```text
Sky Layer Manager.md
Debugger Overhaul 2026-06-01.md
```

Avoid duplicate extensions like:

```text
file.md.md
```

---

## Devlog Naming

For devlogs, topic-first names are allowed because Godot's file dock may shorten filenames.

Recommended devlog format:

```text
topic_yyyy-mm-dd.md
```

Examples:

```text
debugger_overhaul_2026-06-01.md
sky_layer_manager_performance_2026-06-01.md
cloud_drift_tuning_2026-06-02.md
```

This keeps filenames readable inside Godot while still preserving the date.

---

## Release Folder Naming

Use lowercase release folder names with underscores.

Good:

```text
pre_alpha_0_1
pre_alpha_0_2
```

Bad:

```text
Pre Alpha 0.1
Alpha 0.1
pre-alpha-0.1
```

Example:

```text
docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md
```

---

## Final Rule

Docs should make future development easier.

If a document helps explain why a system exists, what changed, or what must happen next, it is worth keeping.

If a document becomes too broad, split it.

If a document is created, it must be discoverable.

If a document is updated, related docs must be reviewed.

No orphan docs.
