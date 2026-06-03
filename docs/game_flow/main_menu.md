# Main Menu Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if main-menu responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when main-menu tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if main-menu behavior, play button, high-score display, auth state, or release readiness changes.
> - `docs/game_flow/boot_flow.md` — update when boot-to-menu flow, auth/session entry, or startup navigation changes.
> - `docs/game_flow/gameplay.md` — update when menu-to-gameplay start flow or return-from-gameplay behavior changes.
> - `docs/game_flow/game_state_map.md` — update when menu state, start-game transition, return-to-menu transition, or future home/sanctuary routing changes.
> - `docs/systems/auth_system.md` — update when menu displays account/guest state, login prompts, or auth recovery behavior.
> - `docs/systems/ui_system.md` — update when menu UI, buttons, high-score UI, or overlay behavior changes.
> - `docs/systems/main_scene_controller.md` — update when main-scene ownership or scene transition responsibility changes.
>
> Do not update this document in isolation when main-menu changes affect boot flow, gameplay start, UI, auth, state flow, release scope, or sprint tasks.

---

# Purpose

This document describes the intended main menu flow for AltarSky.

The main menu is the player-facing entry point for starting a play session and viewing basic prototype state.

---

# Current Status

Main menu is part of the Pre-Alpha 0.1 release target.

The release tracker currently includes:

- Main Menu v1
- Play Button
- Highest Score Display

See:

- `docs/release_tracker/pre_alpha_0_1.md`

---

# Intended Menu Flow

Basic intended flow:

~~~text
Boot
→ Auth/session ready
→ Main Menu
→ Player presses Play
→ Gameplay starts
→ Gameplay ends
→ Return to menu or future home/sanctuary flow
~~~

---

# Required Pre-Alpha 0.1 Menu Behavior

Pre-Alpha 0.1 should support:

- A visible main menu.
- A play/start button.
- Entry into a play session.
- High score display if high score persistence is ready.
- Basic return path after play session or temporary end-session flow.

---

# Auth Relationship

The menu may eventually display:

- Guest account state.
- Login/register prompt.
- Account recovery state.
- Backend/session error state.
- Player name or profile information.

For Pre-Alpha 0.1, the menu should not overcomplicate auth unless required.

Auth should happen during boot/session setup and expose a usable ready state to the menu.

See:

- `docs/systems/auth_system.md`
- `docs/game_flow/boot_flow.md`

---

# Gameplay Relationship

The main menu starts the play session.

Temporary early builds may return to main menu after session end.

However, the long-term intended death flow is:

~~~text
Gameplay
→ Soul-core death sequence
→ Sanctuary / Home
→ Results / Loss Popup
→ Preparation
~~~

Do not let a temporary return-to-menu flow replace the intended sanctuary/home direction.

See:

- `docs/game_flow/gameplay.md`
- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`

---

# UI Relationship

The main menu is part of the UI layer.

Menu UI should be simple for Pre-Alpha 0.1.

It should avoid becoming tangled with debug UI.

Future separation may include:

- MainMenuUI
- GameplayHUD
- PauseMenu
- ResultsPopup
- DebugPanel
- Home/Sanctuary UI

See:

- `docs/systems/ui_system.md`

---

# Pre-Alpha 0.1 Scope

In scope:

- Main Menu v1.
- Play button.
- Highest score display if persistence is ready.
- Basic entry to gameplay.
- Basic return behavior.

Deferrable:

- Full login/register UI.
- Full settings screen.
- Full profile UI.
- Full GamerPal integration.
- Full home/sanctuary menu.
- Full results/loss popup.

---

# Open Questions

- Should Pre-Alpha 0.1 boot directly to main menu or temporarily into gameplay?
- When should home/sanctuary replace return-to-menu after death?
- Should high score display be on main menu or results popup?
- Should guest/auth state be visible in Pre-Alpha 0.1?
- What temporary flow is acceptable before home/sanctuary exists?

---

# Final Rule

The main menu should get the player into the first playable loop quickly.

Temporary menu-return flows are allowed, but they should not overwrite the intended sanctuary/home recovery direction.
