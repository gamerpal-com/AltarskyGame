# Pause Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if pause-flow responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when pause tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if pause behavior becomes required for Pre-Alpha 0.1 scope or release readiness.
> - `docs/game_flow/gameplay.md` — update when pause/resume behavior affects active gameplay, player control, shooting, damage, or session flow.
> - `docs/game_flow/game_state_map.md` — update when pause state, resume transitions, menu return, or state ownership changes.
> - `docs/game_flow/main_menu.md` — update when pause can return to main menu or affects menu navigation.
> - `docs/systems/ui_system.md` — update when pause menu UI, overlay behavior, buttons, or HUD visibility changes.
> - `docs/systems/player_controller.md` — update when pause affects player input, shooting, movement, damage, or control state.
> - `docs/systems/projectile_system.md` — update when pause affects bullet movement, spawning, timers, or projectile cleanup.
>
> Do not update this document in isolation when pause changes affect gameplay, UI, player control, projectiles, state flow, release scope, or sprint tasks.

---

# Purpose

This document describes the intended pause flow for AltarSky.

Pause flow explains what should happen when gameplay is temporarily stopped without ending the run.

---

# Current Status

Pause flow is planned.

A full pause system may not be required for the earliest Pre-Alpha 0.1 build unless it becomes necessary for usability/testing.

---

# Intended Pause Flow

Basic intended flow:

~~~text
Gameplay
→ Pause requested
→ Gameplay pauses
→ Pause UI appears
→ Player chooses Resume
→ Pause UI hides
→ Gameplay resumes
~~~

Possible future options:

~~~text
Gameplay
→ Pause
→ Resume Gameplay
→ Return to Main Menu
→ Settings
→ Quit Run
~~~

---

# Pause vs Death

Pause is not death.

Pause should not trigger:

- Soul-core death sequence.
- Sanctuary return.
- Results/loss popup.
- Inventory loss.
- Score/rank damage.
- Run consequence processing.

Death flow is separate:

~~~text
Gameplay
→ Fatal hit to soul core
→ Death Sequence
→ Sanctuary / Home
→ Results / Loss Popup
~~~

See:

- `docs/game_flow/game_state_map.md`
- `docs/systems/player_soul_core.md`

---

# Gameplay Behavior While Paused

When paused:

- Player input should not move the player.
- Player shooting should stop.
- Enemy/projectile movement should stop.
- Timers should stop or be safely suspended.
- UI should remain responsive.
- Debug UI behavior should be intentional.

The exact technical pause mechanism is not finalized.

---

# UI Relationship

Pause UI should sit above gameplay.

It may cover the soul core because pause is an overlay/menu state, not active dodging gameplay.

During active gameplay, UI should avoid hiding the soul core and enemy projectiles.

During pause, clarity of menu controls is allowed to take priority.

See:

- `docs/systems/ui_system.md`

---

# Pre-Alpha 0.1 Scope

Pause may be deferrable for Pre-Alpha 0.1.

In scope if needed:

- Basic pause/resume.
- Pause overlay.
- Input blocking while paused.
- Safe resume back to gameplay.

Deferrable:

- Settings menu.
- Quit confirmation.
- Return-to-menu flow.
- Pause inventory.
- Pause upgrade menus.
- Full mobile pause UX.

---

# Open Questions

- Is pause required for Pre-Alpha 0.1?
- Should pause stop all timers or only gameplay systems?
- Should debug UI remain usable while paused?
- Should pause be available during death sequence?
- Should pause allow return to main menu before home/sanctuary exists?
- What input opens pause on mobile?

---

# Final Rule

Pause should temporarily stop gameplay without resolving the run.

Pause is a suspended gameplay state, not a death state and not a sanctuary return.
