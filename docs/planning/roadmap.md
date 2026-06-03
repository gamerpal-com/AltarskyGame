# AltarSky Roadmap

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if roadmap responsibilities, source-of-truth routing, active project direction, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if roadmap workflow affects Project Manager Hat, Scrum Master Hat, Developer Hat, Visionary Hat, or Release Manager Hat.
> - `docs/sprints/current_sprint.md` — update when active work, next tasks, deferred ideas, sprint scope, or current focus changes.
> - `docs/release_tracker/pre_alpha_0_1.md` — update when release scope, completion criteria, blockers, or release readiness changes.
> - `docs/planning/shelved_future_documentation.md` — update when future systems are added, removed, re-scoped, or moved into active planning.
> - `docs/planning/sky_time_map.md` — update when sky time, day/night, lighting phase, biome/time, or sky-cycle direction changes.
> - `docs/systems/player_soul_core.md` — update when roadmap direction changes soul core, hitbox, death flow, revival, or player readability priorities.
> - `docs/systems/skyflow_director.md` — update when roadmap direction changes sky/environment orchestration, Sky Layer Manager, or future Skyflow Director priorities.
> - `docs/systems/sky_depth_system.md` — update when roadmap direction changes depth/readability hierarchy or cosmetic/gameplay layer boundaries.
> - `docs/systems/sky_lighting_system.md` — update when roadmap direction changes lighting, time-of-day, death dimming, or sky readability priorities.
>
> Do not update this document in isolation when roadmap changes affect current sprint scope, release readiness, system behavior, planning docs, or future feature priorities.

---

# Purpose

This document tracks the current development direction for AltarSky.

It separates:

- Completed foundation work
- Current active focus
- Near-term goals
- Release priorities
- Future systems
- Shelved / later systems

This roadmap is a planning guide, not the active task tracker.

For active work, use:

- `docs/sprints/current_sprint.md`

For release completion criteria, use:

- `docs/release_tracker/pre_alpha_0_1.md`

---

# Current Project Direction

Current release target:

- Pre-Alpha 0.1

Current active branch:

- `feature/pre-alpha-0.1-sky-layer-manager-depth-lighting`

Current active game-development focus:

- Sky Layer Manager Depth & Lighting

Temporary active meta-development focus:

- Build and test the AltarSky Developer Operating System v1 before returning to high-speed game implementation.

---

# Current Priority Order

Current priority order:

1. Finish Developer Operating System v1 documentation foundation.
2. Validate AI routing / hat switching / documentation workflow.
3. Finish player soul core documentation integration.
4. Return to Sky Layer Manager Depth & Lighting implementation.
5. Validate sky readability around the player soul core and enemy projectile direction.
6. Continue toward Pre-Alpha 0.1 playable loop.

---

# Completed Foundation

The following foundations are complete or substantially established:

- Project setup
- Repository setup
- Godot project foundation
- Main scene controller
- Player controller prototype
- Player movement
- Input system
- Screen boundary protection
- Player sprite integration
- Basic animation support
- Auth system foundation
- Projectile prototype
- UI system foundation
- Debug console system
- Debug console performance overhaul
- Sky Lighting System v1
- Sky Layer Manager foundation
- Cloud asset integration
- Island asset integration
- Dynamic asset spawning
- Asset recycling
- Spawn distribution
- Spawn jitter
- Anti-stacking protection
- ScreenZoneHelper utility
- Documentation folder restructure
- Developer Operating System scaffold
- Start-here routing doc
- Documentation guide
- Project document map
- Development workflow doc
- Current sprint template
- Player soul core system documentation

---

# Active Work

Current active work:

- Developer Operating System validation and cleanup
- Current sprint workflow stabilization
- Remaining planning-doc review
- Soul core documentation integration
- Preparing to return to Sky Layer Manager tuning

Current active Sky Layer Manager work:

- Per-asset drift controls
- Spawn-zone awareness
- Layer movement profiles
- Multi-layer cloud tuning
- Island layer tuning
- Zoom integration
- Lighting integration
- Environmental MVP review
- Sky Layer Manager performance review
- Remaining MVP blocker review

---

# Near-Term Development Targets

## Developer Operating System v1

Goal:

- Make AltarSky work sessions easier, faster, safer, and less chaotic.

Required before returning fully to game development:

- Validate `00_start_here.md` routing.
- Validate hat switching through `03_development_workflow.md`.
- Validate documentation deferral.
- Validate idea parking.
- Validate AI continuous improvement check.
- Confirm current sprint doc works as the active workspace.
- Confirm related docs are updated or deferred intentionally.

---

## Player Soul Core Integration

Goal:

- Make the soul core the source of truth for player hitbox/readability direction.

Completed:

- `docs/systems/player_soul_core.md`
- Gameplay flow integration
- Home/sanctuary flow integration
- Game state map integration
- Player controller integration
- Projectile system integration
- UI system integration
- Skyflow / sky depth / sky lighting integration
- Pre-Alpha 0.1 release tracker note

Remaining:

- Use future implementation work to separate the soul core from the player sprite if practical for Pre-Alpha 0.1.
- Validate soul core readability over sky layers.
- Validate projectile/core readability once enemy projectiles exist.

---

## Sky Layer Manager Depth & Lighting

Goal:

- Make the sky world feel alive, layered, atmospheric, and readable.

Planned features:

- Far cloud layer
- Mid cloud layer
- Near cloud / fog layer
- Distant floating island layer
- Mid-distance floating island layer
- Side-aware drift
- Off-screen spawn support
- Layer movement profiles
- Inspector-exposed tuning
- Zoom responsiveness
- Lighting integration
- Player corridor readability
- Soul-core/projectile readability preservation

Success condition:

- Clouds feel atmospheric.
- Islands feel stable and terrain-like.
- Layer depth creates scale.
- Player soul core remains readable.
- Enemy projectile direction remains readable.
- Sky world feels like a layered moving world instead of a flat background.

---

# Pre-Alpha 0.1 Release Direction

Pre-Alpha 0.1 should demonstrate the core vision of AltarSky through a first playable loop.

Release direction:

- Launch game.
- Enter main menu.
- Start play session.
- Fly through convincing atmospheric sky world.
- Preserve player readability.
- Support player movement.
- Support shooting.
- Add basic enemy.
- Add projectile interaction.
- Earn score.
- Save/view high score.
- Document intended death/sanctuary direction even if not fully implemented.

Soul core direction for Pre-Alpha 0.1:

- Soul core is documented as the true hitbox/readability anchor.
- Soul core implementation should be reviewed if practical.
- Death/sanctuary flow direction should be preserved.
- Full death cinematic can be deferred if needed.

---

# Future Development Targets

Possible future branches / focus areas:

- `feature/enemy-system-v1`
- `feature/projectile-framework-v1`
- `feature/skyflow-director-v1`
- `feature/game-state-flow-v1`
- `feature/player-soul-core-v1`
- `feature/home-sanctuary-v1`
- `feature/developer-os-helper-tools`

---

# Future Systems

Future systems that may become active after Pre-Alpha 0.1 foundation:

- Skyflow Director
- Enemy system
- Projectile framework
- Game state manager
- Home / sanctuary
- Death result popup
- Pet system
- Upgrade/vault flow
- Biome system
- Time-of-day / biome interaction
- Scene map documentation
- Local workflow helper scripts under `tools/docs/`

---

# Shelved / Later

The following are not current priorities:

- Stars
- Nebulae
- Advanced celestial effects
- Guild systems
- Marketplace systems
- PvP systems
- Endgame systems
- Full GamerPal platform integration
- Advanced economy systems
- Full pet system
- Full revive system
- Full death cinematic

These are tracked or should be tracked separately in:

- `docs/planning/shelved_future_documentation.md`

---

# Roadmap Rules

This document should be updated when:

- Active branch changes.
- Active sprint focus changes.
- Release direction changes.
- Major milestone is completed.
- Future system becomes active.
- Active work is deferred.
- Project direction changes.
- Pre-Alpha 0.1 scope changes.

Do not use this document as the daily task list.

Use:

- `docs/sprints/current_sprint.md`

for active sprint/task tracking.

---

# Final Rule

The roadmap should help the user and AI understand where AltarSky is going without derailing the current sprint.

Current sprint owns the now.

Roadmap owns direction.

Planning docs own future possibilities.
