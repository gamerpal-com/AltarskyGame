# Current Sprint

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/00_start_here.md` — review if active-work routing, sprint routing, hat routing, session closeout, or sprint closeout changes.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — review if sprint documentation rules, maintenance-note rules, template rules, or no-orphan-doc rules change.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — review if sprint responsibilities, project-state routing, document flow, or source-of-truth paths change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if sprint workflow, hat workflow, documentation deferral, idea parking, AI guidance, or closeout rules change.
> - `docs/00_ReadMeFirst/templates/current_sprint_template.md` — review if this sprint structure changes.
> - `docs/release_tracker/pre_alpha_0_1.md` — review if release readiness, Pre-Alpha 0.1 scope, blockers, or completion criteria change.
> - Related `docs/systems/`, `docs/game_flow/`, `docs/planning/`, and `docs/01_devlogs/` files — update when sprint work changes system behavior, player flow, future plans, or historical record.
>
> This is the active sprint workspace. Do not delete completed work. Move completed work into the correct permanent docs during sprint closeout before resetting this file from the sprint template.

---

## Sprint Identity

Sprint name:

- Sky Layer Manager Depth & Lighting

Release target:

- Pre-Alpha 0.1

Branch:

- `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`

Sprint status:

- In Progress
- Game development is temporarily paused while the AltarSky Developer Operating System v1 is being built and tested.

Start date:

- Existing sprint started before current documentation operating-system pass.

Target closeout date:

- TODO

Active hats likely needed:

- Development Systems Architect
- Documentation Architect
- Project Manager
- Scrum Master / Sprint Operator
- Developer
- QA / Tester
- Git / Integration Operator

---

## Sprint Goal

Transform the Sky Layer Manager from a functional environmental spawning system into a convincing atmospheric world rendering system.

The sprint should make the sky feel like a layered moving world passing around the player, not a flat background.

The sprint should support:

- Environmental depth
- Movement realism
- Zoom responsiveness
- Lighting integration
- Atmospheric cloud behavior
- Stable terrain-like island behavior
- Player corridor readability
- Bullet-hell visual clarity

---

## Why This Sprint Matters

Previous work established the foundational environmental systems:

- Cloud spawning
- Environmental asset recycling
- Spawn distribution
- Anti-stacking protection
- Atmospheric lighting
- Island layer integration
- ScreenZoneHelper support
- Inspector-driven configuration

This sprint is meant to make those foundations feel alive and visually convincing.

The end result should support the visual identity of AltarSky and establish the foundation for future Skyflow Director development.

A temporary documentation/workflow sub-sprint is also being done inside this sprint because the project needs a reliable Developer Operating System before returning to high-speed game implementation.

---

## Source of Truth / Required Reading

Before working this sprint, review:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/planning/roadmap.md`
- `docs/systems/skyflow_director.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/sky_lighting_system.md`
- `docs/systems/debug_console.md`
- `docs/systems/ui_system.md`
- `docs/game_flow/gameplay.md`

Sprint-specific docs:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`

---

## In Scope

The following work is in scope for this sprint:

- Sky Layer Manager depth and lighting polish
- Per-asset drift controls
- Spawn-zone awareness
- Layer movement profiles
- Multi-layer cloud tuning
- Far / mid / near cloud passes
- Zoom integration
- Lighting integration
- Environmental MVP review
- Sky Layer Manager performance review
- Remaining MVP blocker identification
- Developer Operating System v1 setup before returning to game development
- Current sprint restructure from `current_sprint_template.md`
- Integrating `docs/systems/player_soul_core.md` into related docs after creation
- Updating docs related to player soul core and visual hierarchy after the core OS docs are stable

---

## Out of Scope

The following work is not in scope for this sprint:

- Full Skyflow Director replacement
- Final player animation implementation
- Full enemy system implementation
- Full projectile/bullet-hell combat implementation
- Pet system implementation
- Full biome system implementation
- Full release polish
- Major gameplay expansion outside Pre-Alpha 0.1 needs
- Long-term GamerPal platform/product strategy unless it directly affects current docs
- Building all future helper scripts before the core Developer Operating System is stable
- Creating full scene map documentation unless scene/node confusion becomes an immediate blocker

If an out-of-scope idea appears, park it under:

- `Good Ideas / Not Current Scope`

or the correct planning document.

---

## Current Active Task

Use this section to keep the immediate task visible.

Active task:

- Rebuild `docs/sprints/current_sprint.md` from `docs/00_ReadMeFirst/templates/current_sprint_template.md` while preserving the Sky Layer Manager sprint and Developer Operating System work.

Current hat:

- Development Systems Architect
- Documentation Architect

Current file(s) or doc(s):

- `docs/sprints/current_sprint.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Current blocker, if any:

- None.

Next action:

- Save this rebuilt sprint document.
- Verify diff.
- Commit the sprint rebuild.
- Continue Developer Operating System implementation/testing.
- Then run the initial Developer Operating System validation pass.

---

## Active Tasks

Tasks currently being worked on or approved for this sprint.

### Developer Operating System / Documentation Infrastructure

- [ ] Rebuild `docs/sprints/current_sprint.md` using `docs/00_ReadMeFirst/templates/current_sprint_template.md`.
- [ ] Test the `00_start_here.md` routing flow with simple prompts.
- [ ] Test hat switching using `docs/00_ReadMeFirst/03_development_workflow.md`.
- [ ] Decide whether Developer OS improvement notes stay in `current_sprint.md` or later move to `docs/planning/developer_os_improvement_backlog.md`.
- [x] Finished remaining player soul core planning-doc review: `docs/planning/roadmap.md` and `docs/planning/sky_time_map.md`.
- [ ] Decide where idea capture belongs long-term: sprint doc, planning doc, or separate idea inbox.
- [ ] Run initial AI validation tests before returning to game development.

### Sky Layer Manager

- [ ] Per-Asset Drift
- [ ] Spawn-Zone Awareness
- [ ] Layer Movement Profiles
- [ ] Multi-Layer Cloud Tuning
- [ ] Far Cloud Layer Pass
- [ ] Mid Cloud Layer Pass
- [ ] Near Cloud Layer Pass
- [ ] Zoom Integration
- [ ] Lighting Integration
- [ ] Environmental MVP Review
- [ ] Sky Layer Manager Performance Review
- [ ] Identify Remaining Sky Layer Manager MVP Blockers

---

## Completed This Sprint

Move completed tasks here instead of deleting them.

Completed tasks should later feed devlogs, milestones, release tracker, systems docs, game-flow docs, or planning docs during sprint closeout.

### Environmental Foundation Completed Before / Entering This Sprint

- [x] Sky Lighting System v1
- [x] Sky Layer Foundation
- [x] Cloud Asset Integration
- [x] Island Asset Integration
- [x] Dynamic Asset Spawning
- [x] Asset Recycling
- [x] Spawn Distribution System
- [x] Spawn Jitter System
- [x] Anti-Stacking Protection
- [x] Spawn Validation Logic
- [x] Directional Layer Movement
- [x] Inspector-Driven Configuration
- [x] ScreenZoneHelper Utility

### Major Sky Layer Improvements Already Completed

- [x] Fixed right-side spawn bias.
- [x] Fixed asset center-point spacing calculations.
- [x] Fixed long-runtime spawn distribution inconsistencies.
- [x] Improved recycle behavior for multiple movement directions.
- [x] Improved asset spacing reliability.
- [x] Improved environmental density consistency.
- [x] Improved sky layer movement and drift controls.

### Supporting Work Completed During This Sprint

- [x] Identified debugger-related performance issue during profiling.
- [x] Separated logger signal handling from expensive UI rendering.
- [x] Added log levels: ERROR, WARNING, SYSTEM, INFO, VERBOSE.
- [x] Added filtered debug display.
- [x] Added snapshot-based log display.
- [x] Added optional live log display.
- [x] Added progressive log loading.
- [x] Added capped visible log buffer.
- [x] Added mobile-friendly debug filter buttons.
- [x] Updated debugger, UI, milestone, and devlog documentation.
- [x] Tuned prototype player fire interval.

### Developer Operating System / Documentation Work Completed

- [x] Updated `docs/planning/roadmap.md` and `docs/planning/sky_time_map.md` after player soul core integration.
- [x] Updated `docs/release_tracker/pre_alpha_0_1.md` with player soul core release-scope tracking.
- [x] Updated `docs/00_ReadMeFirst/02_project_document_map.md` so `docs/systems/player_soul_core.md` is listed as a current system doc.
- [x] Documented soul-core gameplay/death/sanctuary flow in `docs/game_flow/gameplay.md`, `docs/game_flow/home.md`, and `docs/game_flow/game_state_map.md`.
- [x] Integrated soul-core rules into `docs/systems/player_controller.md`, `docs/systems/projectile_system.md`, and `docs/systems/ui_system.md`.
- [x] Integrated soul-core readability rules into `docs/systems/skyflow_director.md`, `docs/systems/sky_depth_system.md`, and `docs/systems/sky_lighting_system.md`.
- [x] Created and committed `docs/systems/player_soul_core.md`.
- [x] Confirmed real Godot project path and fixed duplicate-folder confusion.
- [x] Quarantined wrong duplicate folder.
- [x] Added symlink so `~/Projects/AltarskyGame` points to the real Godot project.
- [x] Reorganized docs into final folder structure:
  - `docs/00_ReadMeFirst/`
  - `docs/01_devlogs/`
  - `docs/game_flow/`
  - `docs/planning/`
  - `docs/release_tracker/`
  - `docs/sprints/`
  - `docs/systems/`
- [x] Fixed `docs/00_ReadMeFirst/01_documentation_guide.md` Markdown structure.
- [x] Committed documentation structure cleanup separately from code changes.
- [x] Split remaining code/scene work into clean commits.
- [x] Created and committed `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`.
- [x] Created and committed `docs/00_ReadMeFirst/00_start_here.md`.
- [x] Renamed the documentation guide to `docs/00_ReadMeFirst/01_documentation_guide.md`.
- [x] Created and committed `docs/00_ReadMeFirst/02_project_document_map.md`.
- [x] Created and committed `docs/00_ReadMeFirst/03_development_workflow.md`.
- [x] Created and committed `docs/00_ReadMeFirst/templates/current_sprint_template.md`.

---

## Decisions Made This Sprint

Record decisions made during this sprint.

Include enough context that future-you or an AI can understand why the decision was made.

### Clouds

- Decision:
  - Clouds represent atmospheric movement and weather.
- Context:
  - Clouds should make the sky feel alive and naturally flowing.
- Reason:
  - Clouds are atmospheric elements, not terrain.
- Affected docs:
  - `docs/systems/skyflow_director.md`
  - `docs/systems/sky_depth_system.md`
  - Future scene map docs if created.
- Follow-up:
  - Tune far/mid/near cloud passes.

Cloud requirements:

- Horizontal drift enabled.
- Spawn-zone awareness enabled.
- Speed variation allowed.
- Future rotation support possible.

### Islands

- Decision:
  - Islands represent terrain and landmarks within the world.
- Context:
  - Islands should feel massive, grounded, and below/around the player.
- Reason:
  - Islands should not behave like weather.
- Affected docs:
  - `docs/systems/skyflow_director.md`
  - `docs/systems/sky_depth_system.md`
  - Future scene map docs if created.
- Follow-up:
  - Tune island motion and stability.

Island requirements:

- Horizontal drift disabled.
- Terrain-like movement behavior.
- Stable positioning.
- Future streaming support.

### Future Environmental Layers

- Decision:
  - Future environmental layers should be configurable through the Sky Layer Manager rather than requiring separate hardcoded systems.
- Context:
  - Fog, debris, atmospheric particles, flying creatures, and effects may need future layers.
- Reason:
  - Layer behavior should be controlled through configuration whenever possible.
- Affected docs:
  - `docs/systems/skyflow_director.md`
  - `docs/systems/sky_depth_system.md`
  - `docs/planning/roadmap.md`
- Follow-up:
  - Preserve inspector-driven tuning direction.

### Developer Operating System

- Decision:
  - Pause AltarSky game development until the Developer Operating System v1 is functional enough to guide future work.
- Context:
  - The project needs a repo-based source of truth, hat-based workflow, documentation rules, templates, AI guidance, and drift control.
- Reason:
  - AI has accelerated development, but workflow drift can cause repo/doc chaos if the operating system is not stable.
- Affected docs:
  - `docs/00_ReadMeFirst/00_start_here.md`
  - `docs/00_ReadMeFirst/01_documentation_guide.md`
  - `docs/00_ReadMeFirst/02_project_document_map.md`
  - `docs/00_ReadMeFirst/03_development_workflow.md`
  - `docs/00_ReadMeFirst/templates/current_sprint_template.md`
  - `docs/sprints/current_sprint.md`
- Follow-up:
  - Test the AI against the system before returning to Sky Layer Manager implementation.

---

## Blockers / Risks

Track anything blocking progress or creating risk.

### Rotation-Aware Spacing

- Blocker/Risk:
  - Rotation itself is functioning correctly, but spacing calculations do not currently account for rotated asset bounds.
- Source:
  - Sky Layer Manager testing.
- Impact:
  - Rotational variance cannot be safely enabled on larger environmental assets until spacing accounts for rotated bounds.
- Owner/Hat:
  - Developer
  - QA / Tester
- Next action:
  - Defer rotation-aware spacing until needed or until large rotated assets become current scope.
- Status:
  - Open.

### Idle Performance Spike

- Blocker/Risk:
  - A periodic stutter still occurs while the game is idle.
- Source:
  - Performance investigation.
- Impact:
  - Could affect runtime smoothness if confirmed outside editor/profiler.
- Owner/Hat:
  - Developer
  - QA / Tester
- Next action:
  - Do not keep chasing editor/profiler spikes unless exported/runtime testing confirms visible stutter.
  - If confirmed, investigate Sky Layer Manager, asset recycling, spawn validation, layer tuning, or rendering behavior.
- Status:
  - Open / watch only.

### Spawn Zone Tracking

- Blocker/Risk:
  - Current ScreenZoneHelper logic assumes visible screen bounds.
- Source:
  - Sky Layer Manager requirements.
- Impact:
  - Environmental assets that spawn before entering visible play area may need off-screen tracking support.
- Owner/Hat:
  - Developer
- Next action:
  - Add off-screen spawn patch/support when Sky Layer Manager tuning resumes.
- Status:
  - Open.

### System Integration

- Blocker/Risk:
  - Sky Layer Manager, Zoom System, and Sky Lighting System currently exist independently and still require integration.
- Source:
  - Sprint scope.
- Impact:
  - Environmental presentation will remain incomplete until the systems respond together.
- Owner/Hat:
  - Developer
- Next action:
  - Connect zoom and lighting integration after Developer Operating System work is stable.
- Status:
  - Open.

### System Drift

- Blocker/Risk:
  - Developer Operating System rules may be skipped during high-energy game development.
- Source:
  - Workflow design discussion.
- Impact:
  - Documentation and workflow could drift even after the system is built.
- Owner/Hat:
  - Development Systems Architect
  - Documentation Architect
- Next action:
  - Test AI routing, hat switching, documentation deferral, and improvement capture before returning to game development.
- Status:
  - Open.

---

## Good Ideas / Not Current Scope

Park useful ideas here when they should not derail the current sprint.

These should be reviewed during sprint closeout.

- Idea:
  - Add a future dedicated `docs/planning/idea_inbox.md`.
  - Source hat:
    - Development Systems Architect
  - Why it is not current scope:
    - Current sprint can use this section for idea parking until repeated need proves a separate doc is needed.
  - Review as:
    - Project Manager
    - Development Systems Architect
  - Possible destination:
    - `docs/planning/idea_inbox.md`

- Idea:
  - Add future `docs/scene_maps/` folder for Godot scene trees, nodes, inspector settings, exported variables, signal connections, and scene-specific tuning values.
  - Source hat:
    - Documentation Architect
    - Development Systems Architect
  - Why it is not current scope:
    - Core Developer Operating System docs should stabilize first unless scene/node confusion becomes an immediate blocker.
  - Review as:
    - Documentation Architect
  - Possible destination:
    - `docs/scene_maps/`
    - `docs/00_ReadMeFirst/templates/scene_map_template.md`

- Idea:
  - Add future new maintainer onboarding doc.
  - Source hat:
    - Development Systems Architect
  - Why it is not current scope:
    - Current system is still being built and tested for the user/AI first.
  - Review as:
    - Development Systems Architect
    - Documentation Architect
  - Possible destination:
    - `docs/00_ReadMeFirst/04_new_maintainer_onboarding.md`
    - `docs/00_ReadMeFirst/templates/new_maintainer_onboarding_template.md`

---

## Developer OS Improvement Notes

Park workflow/system improvement ideas here when they should not derail the current sprint.

Review later while wearing Development Systems Architect Hat.

Before adding a new item, check this section to avoid duplicates.

- Improvement idea:
  - Add local workflow helper tools after the core docs are stable.
  - Source hat:
    - Development Systems Architect
  - Friction / reason:
    - Vague instructions like "update the devlog" are inefficient and likely to cause drift.
  - Suggested fix:
    - Build `tools/docs/` helper scripts for repeated actions such as parking ideas, adding blockers, adding documentation TODOs, adding session logs, and adding OS improvement notes.
  - Review as:
    - Development Systems Architect
    - Git / Integration Operator
  - Possible affected docs:
    - `docs/00_ReadMeFirst/03_development_workflow.md`
    - `docs/00_ReadMeFirst/templates/current_sprint_template.md`
    - Future `tools/docs/`

- Improvement idea:
  - Add duplicate-checking to AI continuous improvement suggestions.
  - Source hat:
    - Development Systems Architect
  - Friction / reason:
    - AI may repeatedly suggest the same system improvements unless it checks existing notes first.
  - Suggested fix:
    - AI should check this section, current sprint deferred notes, and future OS backlog before suggesting new improvements.
  - Review as:
    - Development Systems Architect
  - Possible affected docs:
    - `docs/00_ReadMeFirst/00_start_here.md`
    - `docs/00_ReadMeFirst/03_development_workflow.md`

---

## Documentation TODO / Deferred Updates

Use this section when docs should be updated later instead of interrupting active work.

- Documentation completed:
  - Reason:
    - Finished remaining planning-doc review after player soul core documentation integration.
  - Updated docs:
    - `docs/planning/roadmap.md`
    - `docs/planning/sky_time_map.md`
  - Source hat:
    - Development Systems Architect
    - Documentation Architect
  - Status:
    - Completed.

- Documentation TODO:
  - Reason:
    - Remaining placeholder docs need content or review.
  - Affected docs:
    - `docs/game_flow/boot_flow.md`
    - `docs/game_flow/inventory.md`
    - `docs/game_flow/main_menu.md`
    - `docs/game_flow/paused.md`
    - `docs/planning/sky_time_map.md`
  - Source hat:
    - Documentation Architect
  - Review as:
    - Documentation Architect
  - Status:
    - Open.

- Documentation TODO:
  - Reason:
    - `docs/planning/roadmap.md` may contain stale branch/focus references.
  - Affected docs:
    - `docs/planning/roadmap.md`
  - Source hat:
    - Documentation Architect
  - Review as:
    - Project Manager
    - Documentation Architect
  - Status:
    - Open.

---

## Session Logs / Work Notes

Use this section for short session logs or work summaries when a separate devlog is not needed yet.

Long or historically important work should become a devlog under `docs/01_devlogs/`.

- Date:
  - Current documentation operating-system pass.
  - Active hat:
    - Development Systems Architect
    - Documentation Architect
    - Git / Integration Operator
  - Goal:
    - Build the AltarSky Developer Operating System enough to guide future AI/user work.
  - Completed:
    - Fixed repo path confusion.
    - Reorganized docs.
    - Created start-here router.
    - Created documentation guide structure.
    - Created project document map.
    - Created development workflow.
    - Created current sprint template.
  - Decisions:
    - Pause game development until the Developer Operating System is working as expected.
    - Use repo docs as source of truth.
    - Use hats/work modes to control abstraction.
    - Use current sprint as temporary parking lot for ideas, OS improvements, and documentation TODOs.
  - Blockers:
    - Player soul core doc has been created and integrated into release tracker, game-flow docs, player/projectile/UI docs, and sky-system docs; remaining review is limited to planning docs.
    - Current sprint still needs validation after rebuild.
  - Ideas parked:
    - Future scene maps.
    - Future new maintainer onboarding.
    - Future local helper tools.
    - Future dedicated idea inbox.
  - Documentation TODOs:
    - Review remaining planning docs affected by player soul core direction.
    - Initial player soul core planning-doc review completed.
    - Review placeholder docs.
  - Next step:
    - Save and commit rebuilt `docs/sprints/current_sprint.md`.
    - Then run the initial Developer Operating System validation pass.

---

## QA / Validation Notes

Use this section to track testing, validation, devices, regressions, and pass/fail results.

Validation notes:

- Test:
  - AI routing from `00_start_here.md`
  - Environment:
    - ChatGPT project conversation using repo docs as source of truth.
  - Expected:
    - AI should identify hat/work mode and route to correct docs.
  - Actual:
    - TODO
  - Result:
    - Pending.
  - Follow-up:
    - Run validation prompts from `docs/00_ReadMeFirst/03_development_workflow.md`.

- Test:
  - Hat switching
  - Environment:
    - ChatGPT project conversation.
  - Expected:
    - User says "I am switching to X hat"; AI runs startup/handoff logic.
  - Actual:
    - TODO
  - Result:
    - Pending.
  - Follow-up:
    - Test Developer, Visionary, Documentation Architect, and Git / Integration Operator transitions.

- Test:
  - Documentation deferral and idea parking
  - Environment:
    - ChatGPT project conversation.
  - Expected:
    - AI parks ideas or doc TODOs instead of derailing active work.
  - Actual:
    - TODO
  - Result:
    - Pending.
  - Follow-up:
    - Test during a fake Developer Hat session.

---

## Git / Integration Notes

Use this section to track branch, commit, merge, push, or repo safety notes.

- Git note:
  - Branch:
    - `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`
  - Status:
    - Clean before rebuilding current sprint document.
  - Commit(s):
    - Documentation structure cleanup committed.
    - Debug console logging overhaul committed.
    - Sky layer movement/drift controls committed.
    - Prototype fire interval tuning committed.
    - Developer OS scaffold committed.
    - Start-here routing doc committed.
    - Project document map committed.
    - Development workflow committed.
    - Current sprint template committed.
  - Push status:
    - Pushed before current sprint rebuild.
  - Follow-up:
    - Commit and push current sprint rebuild separately.

---

## Files / Docs Changed This Sprint

Track important files and docs touched during this sprint.

Code / scene / asset files:

- `scripts/_core/Logger.gd`
- `scripts/ui/DebugPanel.gd`
- `scripts/gameplay/skybackgroundscripts/SkyLayer.gd`
- `scenes/UI_Main.tscn`
- `scenes/SkyLayerSystem.tscn`
- `scenes/_Main.tscn`

Documentation files:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`
- `docs/sprints/current_sprint.md`
- `docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md`
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md`
- `docs/01_devlogs/project_milestones.md`
- `docs/release_tracker/pre_alpha_0_1.md`
- `docs/systems/debug_console.md`
- `docs/systems/ui_system.md`

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

- Continue Sky Layer Manager Depth & Lighting implementation after Developer Operating System validation.
- Continue environmental depth tuning.
- Implement or tune off-screen spawn zone support.
- Integrate zoom behavior with environmental presentation.
- Integrate lighting behavior with environmental presentation.
- Begin future Skyflow Director Foundation after Sky Layer Manager MVP is complete.
- Build local `tools/docs/` workflow helper scripts after the core Developer Operating System is stable.
- Add future scene map docs if scene/node/inspector structure becomes a recurring friction point.

---

## Sprint Closeout / Archive Notes

Use this section during closeout to note where sprint knowledge was moved.

Archive notes:

- Closeout note:
  - Moved to:
    - TODO
  - Reason:
    - TODO
  - Follow-up:
    - TODO

---

# Template Use Rule

This sprint document now follows `docs/00_ReadMeFirst/templates/current_sprint_template.md`.

At sprint closeout:

1. Preserve completed sprint knowledge.
2. Move or carry forward unresolved work.
3. Copy the template into `docs/sprints/current_sprint.md`.
4. Replace TODO placeholders with the next sprint's real information.
5. Commit the sprint reset.

Never reset `docs/sprints/current_sprint.md` from memory once the template exists.

## Developer OS Improvement Notes — Hat Switch Validation Logging

- Improvement idea:
  - Source hat:
    - Development Systems Architect
  - Friction / reason:
    - During AI validation, switching into Developer Hat worked correctly, but the system did not automatically preserve the validation result or handoff status in the repo.
  - Suggested fix:
    - Add a lightweight hat-switch / validation logging rule so successful or failed hat transitions can be recorded when useful.
    - The log should capture previous hat, new hat, handoff status, whether docs/tasks need updates, validation pass/fail, and next intended action.
  - Review as:
    - Development Systems Architect
    - Scrum Master / Sprint Operator
  - Possible affected docs:
    - `docs/00_ReadMeFirst/03_development_workflow.md`
    - `docs/sprints/current_sprint.md`
    - Future `tools/docs/add_hat_switch_log.sh`
  - Status:
    - Parked for review.


## AI Validation Notes — Developer Hat / Fresh Chat

- Validation test:
  - Scenario:
    - Fresh-chat AI was instructed to use branch `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`, start from `docs/00_ReadMeFirst/00_start_here.md`, and enter Developer Hat.
  - Result:
    - Passed with correction.
  - What worked:
    - AI did not default to `main`.
    - AI recognized the correct feature branch.
    - AI routed through Developer Hat instead of rewriting the operating system.
    - AI checked Git status before implementation.
    - AI identified that an uncommitted sprint note should be reviewed before coding.
    - AI gave one next instruction at a time.
  - Issue found:
    - When challenged with "I do not want to commit yet, I want to start coding anyway," AI initially allowed coding with a dirty tree instead of pushing back.
  - Correction accepted:
    - AI accepted that before implementation it should require one of:
      - Commit
      - Stash
      - Explicit dirty-tree acceptance
  - Follow-up:
    - Consider adding a formal dirty-tree implementation guardrail to `docs/00_ReadMeFirst/03_development_workflow.md`.
    - Consider adding future helper script `tools/docs/add_hat_switch_log.sh` or `tools/docs/add_validation_note.sh`.


## AI Validation Notes — Developer Operating System Batch 1

- Validation batch:
  - Source hats:
    - QA / Tester
    - Development Systems Architect
  - Purpose:
    - Test whether a fresh AI session can follow the AltarSky Developer Operating System using the feature branch as source of truth.

- Tests completed:
  - Developer Hat switch:
    - Result: Pass.
    - Notes:
      - AI identified Developer Hat.
      - AI checked sprint/source docs.
      - AI avoided dumping a giant checklist.
  - Fresh-chat source-of-truth / branch test:
    - Result: Pass.
    - Notes:
      - AI did not default to main.
      - AI used `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`.
      - Minor issue: command path/formatting needed correction.
  - Dirty-tree guardrail test:
    - Result: Partial fail, corrected after feedback.
    - Notes:
      - AI initially allowed coding with uncommitted sprint-doc changes.
      - Corrected rule: before implementation, require commit, stash, discard, or explicit dirty-tree acceptance after inspecting changes.
  - Blowout / out-of-scope pet idea test:
    - Result: Pass with improvement notes.
    - Notes:
      - AI correctly parked the pet idea instead of derailing Sky Layer Manager work.
      - Improvements needed: use official hat names, prefer existing sprint sections, avoid TODO placeholders when the actual idea can be requested first.
  - Documentation update test:
    - Result: Partial fail.
    - Notes:
      - AI shifted toward documentation mode.
      - It should have asked what changed before assuming the update was about the pet idea.
      - It should provide exact paths/commands after identifying the change.
  - Developer Hat to Visionary / Concept Designer Hat switch:
    - Result: Pass with command-format issue.
    - Notes:
      - AI recognized the official target hat.
      - AI required worktree/handoff check before concept capture.
      - Command formatting was smashed together.
  - Stand-Down Update test:
    - Result: Pass with improvement notes.
    - Notes:
      - AI used the correct Stand-Down Update heading.
      - AI used first-person wording.
      - AI ended with "Signing off."
      - Improvement needed: include exact paste destination or terminal append command.

- Findings to convert into OS rules:
  - Add formal AI Behavior Validation Loop.
  - Add dirty-tree implementation guardrail.
  - Add official hat-name rule.
  - Add hat handoff checkpoint rule.
  - Add parking-location rule that prefers existing sprint sections.
  - Add terminal-output rule preferring `git --no-pager diff`.
  - Add documentation-update rule requiring "what changed?" before routing.
  - Add idea-capture rule asking for the actual idea before generating TODO placeholders when practical.
  - Add Stand-Down/session-log rule requiring paste destination or terminal append command.
  - Add command-format rule requiring clean multi-line terminal commands.

- My assistant failure during this session:
  - I failed to correctly identify that we were taking off QA / Tester Hat before switching modes.
  - I also failed to confirm whether validation findings were safely stored before proceeding.
  - Correction:
    - On hat switch, run a Hat Handoff Checkpoint and confirm findings are logged, parked, committed, deferred, or intentionally carried forward.

- Recommended next hat:
  - Development Systems Architect
  - Reason:
    - Convert validation findings into formal OS workflow rules.

- Status:
  - Stored for follow-up.


## AI Validation Addendum — Hat-Off Without Target Hat

- Validation finding:
  - Source hats:
    - QA / Tester
    - Development Systems Architect
  - Scenario:
    - User said they were taking off QA / Tester Hat but did not immediately specify which hat was going on next.
  - Result:
    - Partial fail.
  - What happened:
    - AI inferred the likely next hat instead of first running a complete hat handoff checkpoint.
    - AI also needed prompting to confirm whether validation findings had been safely stored before switching modes.
  - Correct behavior:
    - When a user says they are taking off a hat, AI should pause and run a Hat Handoff Checkpoint.
    - AI should identify the current hat being removed.
    - AI should confirm whether findings, notes, work, or dirty-tree changes are stored, parked, committed, deferred, or intentionally carried forward.
    - AI should ask which hat the user is putting on next.
    - AI may recommend a likely next hat, but should not fully switch without confirmation unless the user has defined a default.
  - Suggested OS rule:
    - Add a formal Hat Handoff Checkpoint rule to `docs/00_ReadMeFirst/03_development_workflow.md`.
    - Include a default recommendation rule:
      - If no target hat is named, suggest the likely next hat and ask for confirmation.
  - Status:
    - Stored for Development Systems Architect review.
## Developer OS Improvement Notes — Memory Offload / Forget Checkpoint

- Improvement idea:
  - Source hat:
    - Development Systems Architect
    - QA / Tester
  - Friction / reason:
    - During active testing/development, AI short-term chat memory is useful for holding temporary findings without forcing immediate repo updates after every observation.
    - However, before ending a session, switching hats, resetting context, or relying on another AI session, important findings need to be offloaded into the repo and confirmed stored.
  - Suggested rule:
    - Use AI/chat memory as temporary working memory during an active session.
    - Use `docs/sprints/current_sprint.md` as sprint/session memory.
    - Use system/planning/workflow docs as durable source-of-truth memory only after review.
    - Before stand-down, hat handoff, context reset, or session end, run a Memory Offload Checkpoint.
    - The checkpoint should ask:
      - What temporary findings are currently only in chat memory?
      - Which findings need to be stored in the repo?
      - Which findings can be ignored?
      - Which findings should become formal rules later?
      - Has the repo update been committed/pushed?
      - Can temporary memory/scratchpad context now be forgotten?
  - Suggested fixes:
    - Add a Memory Offload / Forget Checkpoint rule to `docs/00_ReadMeFirst/03_development_workflow.md`.
    - Add memory-offload reminder to Stand-Down/session-log workflow.
    - Consider future helper script `tools/docs/add_memory_offload_note.sh`.
  - Review as:
    - Development Systems Architect
    - Documentation Architect
  - Possible affected docs:
    - `docs/00_ReadMeFirst/03_development_workflow.md`
    - `docs/00_ReadMeFirst/templates/current_sprint_template.md`
    - `docs/sprints/current_sprint.md`
    - Future `tools/docs/add_memory_offload_note.sh`
  - Status:
    - Parked for review.

## Session Logs / Work Notes — Stand-Down Update

- Date:
  - 2026-06-03
- Active hats:
  - QA / Tester
  - Development Systems Architect
  - Documentation Architect
- Goal:
  - Validate the AltarSky Developer Operating System behavior and convert the first validation findings into workflow rules.
- Completed:
  - Ran fresh-chat AI validation against the feature branch instead of `main`.
  - Confirmed Developer Hat routing mostly works.
  - Confirmed out-of-scope idea parking mostly works.
  - Confirmed hat-switch handoff mostly works.
  - Confirmed Stand-Down Update style mostly works.
  - Found and stored validation findings in `docs/sprints/current_sprint.md`.
  - Added formal AI behavior validation, dirty-tree, hat handoff, official hat-name, `git --no-pager diff`, documentation-update, and Stand-Down/session-log rules to `docs/00_ReadMeFirst/03_development_workflow.md`.
  - Updated `docs/00_ReadMeFirst/templates/current_sprint_template.md` with stronger QA/validation and session-log fields.
  - Identified a new Memory Offload / Forget Checkpoint idea for future workflow improvement.
- Decisions:
  - AI short-term memory can be used during active work/testing.
  - Durable project truth should still be stored in Git-backed repo docs.
  - Findings should be pooled during active testing and offloaded at handoff/stand-down instead of triggering constant immediate doc updates.
- Blockers:
  - None.
- Follow-up:
  - Review and formalize Memory Offload / Forget Checkpoint later.
  - Decide whether documentation batching/cadence also needs its own explicit rule.
  - Continue validation/retest after rest.
- Next step:
  - Sleep/rest.
  - Next session should start by checking git status and reading `docs/sprints/current_sprint.md`.
- Signing off.


## Developer OS Improvement Notes — Memory Offload / Forget Checkpoint

- Improvement idea:
  - Source hat:
    - Development Systems Architect
    - QA / Tester
  - Friction / reason:
    - During active testing/development, AI short-term chat memory is useful for holding temporary findings without forcing immediate repo updates after every observation.
    - However, before ending a session, switching hats, resetting context, or relying on another AI session, important findings need to be offloaded into the repo and confirmed stored.
  - Suggested rule:
    - Use AI/chat memory as temporary working memory during an active session.
    - Use `docs/sprints/current_sprint.md` as sprint/session memory.
    - Use system/planning/workflow docs as durable source-of-truth memory only after review.
    - Before stand-down, hat handoff, context reset, or session end, run a Memory Offload Checkpoint.
    - The checkpoint should ask:
      - What temporary findings are currently only in chat memory?
      - Which findings need to be stored in the repo?
      - Which findings can be ignored?
      - Which findings should become formal rules later?
      - Has the repo update been committed/pushed?
      - Can temporary memory/scratchpad context now be forgotten?
  - Suggested fixes:
    - Add a Memory Offload / Forget Checkpoint rule to `docs/00_ReadMeFirst/03_development_workflow.md`.
    - Add memory-offload reminder to Stand-Down/session-log workflow.
    - Consider future helper script `tools/docs/add_memory_offload_note.sh`.
  - Review as:
    - Development Systems Architect
    - Documentation Architect
  - Possible affected docs:
    - `docs/00_ReadMeFirst/03_development_workflow.md`
    - `docs/00_ReadMeFirst/templates/current_sprint_template.md`
    - `docs/sprints/current_sprint.md`
    - Future `tools/docs/add_memory_offload_note.sh`
  - Status:
    - Parked for review.

## Session Logs / Work Notes — Stand-Down Update

- Date:
  - 2026-06-03
- Active hats:
  - QA / Tester
  - Development Systems Architect
  - Documentation Architect
- Goal:
  - Validate the AltarSky Developer Operating System behavior and convert the first validation findings into workflow rules.
- Completed:
  - Ran fresh-chat AI validation against the feature branch instead of `main`.
  - Confirmed Developer Hat routing mostly works.
  - Confirmed out-of-scope idea parking mostly works.
  - Confirmed hat-switch handoff mostly works.
  - Confirmed Stand-Down Update style mostly works.
  - Found and stored validation findings in `docs/sprints/current_sprint.md`.
  - Added formal AI behavior validation, dirty-tree, hat handoff, official hat-name, `git --no-pager diff`, documentation-update, and Stand-Down/session-log rules to `docs/00_ReadMeFirst/03_development_workflow.md`.
  - Updated `docs/00_ReadMeFirst/templates/current_sprint_template.md` with stronger QA/validation and session-log fields.
  - Identified a new Memory Offload / Forget Checkpoint idea for future workflow improvement.
- Decisions:
  - AI short-term memory can be used during active work/testing.
  - Durable project truth should still be stored in Git-backed repo docs.
  - Findings should be pooled during active testing and offloaded at handoff/stand-down instead of triggering constant immediate doc updates.
- Blockers:
  - None.
- Follow-up:
  - Review and formalize Memory Offload / Forget Checkpoint later.
  - Decide whether documentation batching/cadence also needs its own explicit rule.
  - Continue validation/retest after rest.
- Next step:
  - Sleep/rest.
  - Next session should start by checking git status and reading `docs/sprints/current_sprint.md`.
- Signing off.

## Developer OS Improvement Notes — Minimal Developer Documentation Loop

- Update:
  - Source hat:
    - Development Systems Architect
  - Reason:
    - Scope is being cut back so game development can resume.
    - Full Developer Operating System vision remains, but day-to-day workflow should become simpler.
  - Minimal working mode:
    - Developer Mode:
      - User codes.
      - AI tracks important changes in short-term session memory.
      - AI avoids constant documentation interruptions.
    - Documentation Backup Mode:
      - At task/session checkpoints, AI gives one clean append/update command.
      - User pastes once and moves on.
    - Cleanup Mode:
      - Later, Documentation Architect / Development Systems Architect cleans, organizes, and commits documentation batches.
  - Helper script added:
    - `tools/docs/append_to_sprint.sh`
  - Status:
    - Parked/implemented as lightweight workflow support so development can resume.
