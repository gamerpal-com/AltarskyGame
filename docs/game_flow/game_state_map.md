# Game State Map

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if game-state document responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when game-state tasks, completed work, blockers, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if game-state flow changes Pre-Alpha 0.1 completion criteria or release readiness.
> - `docs/game_flow/gameplay.md` — update when active gameplay, damage, death, run state, or combat flow changes.
> - `docs/game_flow/home.md` — update when sanctuary/home state, death return, wake-up, or preparation flow changes.
> - `docs/game_flow/main_menu.md` — update when menu-to-gameplay or gameplay-to-menu flow changes.
> - `docs/game_flow/paused.md` — update when pause state transitions change.
> - `docs/systems/player_soul_core.md` — update when soul core death, revival, sanctuary return, or state transition behavior changes.
> - `docs/systems/main_scene_controller.md` — update when scene/state ownership or transition control changes.
> - `docs/systems/ui_system.md` — update when state transitions affect UI, post-death popup, HUD, pause UI, or menu UI.
>
> Do not update this document in isolation when state transitions affect gameplay, home/sanctuary, soul core death flow, UI, or release criteria.

---

# Purpose

This document maps major player/game states and transitions.

It is the high-level state flow reference for gameplay, menu, sanctuary/home, death, pause, and future run flow.

---

# Current Major States

Current and planned states:

- Boot
- Main Menu
- Gameplay
- Pause
- Death Sequence
- Sanctuary / Home
- Results / Loss Popup
- Preparation
- Future Run Start
- Future Run Complete
- Future Revival

Not all states need to be fully implemented in Pre-Alpha 0.1.

---

# Core State Flow

Intended high-level flow:

1. Boot
2. Main Menu
3. Gameplay
4. Gameplay result path:
   - Death Sequence
   - Run Complete / Return Home
   - Pause / Resume
5. Sanctuary / Home
6. Results / Loss Popup if applicable
7. Preparation
8. Next run or return to menu

---

# Gameplay to Death to Sanctuary Flow

Death should not be treated as a direct hard game-over menu.

Intended death state chain:

~~~text
Gameplay
→ Fatal hit to soul core
→ Death Sequence
→ Fade out
→ Sanctuary / Home
→ Player wakes / reforms / stabilizes
→ Results / Loss Popup
→ Preparation
→ Next run or menu
~~~

This flow exists because:

- The soul core is the true player.
- The body is an astral projection.
- Death is soul-core fracture and projection rupture.
- Sanctuary/home is the recovery space.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/home.md`

---

# Temporary Pre-Alpha Flow

If sanctuary/home is not implemented yet, a temporary return flow may be used.

Temporary flow must be clearly marked as temporary.

Possible temporary flow:

~~~text
Gameplay
→ Fatal hit / session end
→ Temporary results or menu return
~~~

But the intended final direction remains:

~~~text
Gameplay
→ Soul-core death sequence
→ Sanctuary wake-up
→ Results/loss popup
→ Preparation
~~~

Do not let a temporary hard game-over/menu flow become the final design by accident.

---

# Pause State

Pause state should preserve the current gameplay session.

Basic flow:

~~~text
Gameplay
→ Pause
→ Resume Gameplay
~~~

Pause should not be confused with death, sanctuary, or run completion.

---

# Results / Loss Popup State

The results/loss popup should appear after the player returns to sanctuary from death or run completion.

It should not appear before the death sequence completes.

It should eventually display:

- Score
- Losses
- Rank damage
- Items lost
- Temporary upgrades lost
- Rewards preserved
- Next preparation options

---

# Revival State

Revival is a future hook.

Possible future flow:

~~~text
Gameplay
→ Fatal hit to soul core
→ Death Sequence begins
→ Revival trigger
→ Soul core re-stabilizes
→ Projection reforms
→ Gameplay resumes or returns to safe state
~~~

Revival should preserve the rule that the soul core is the true player.

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should at minimum keep the intended state direction documented.

Required now:

- Main gameplay loop can be reasoned about.
- Death/sanctuary direction is documented.
- Soul core relationship to death flow is documented.
- Temporary flows are marked as temporary if used.

Possible deferrals:

- Full sanctuary state.
- Full results/loss popup.
- Full revival state.
- Full preparation state.
- Full run-complete state.

---

# Open Questions

- What temporary death/end-session flow should Pre-Alpha 0.1 use before sanctuary exists?
- Should sanctuary/home exist as a placeholder scene before full gameplay loop is done?
- Which system owns state transitions: main scene controller, gameplay controller, UI system, or future game state manager?
- When should results/loss popup be required?
- How should revival interrupt or replace death state?

---

# Final Rule

State flow should preserve AltarSky's soft-break philosophy.

Death should feel like soul-core rupture and sanctuary return, not a normal arcade reset.

Temporary flows are allowed, but they must not overwrite the intended design direction.
