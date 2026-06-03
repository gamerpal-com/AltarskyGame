# Boot Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if boot-flow responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when boot-flow tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if boot behavior, startup readiness, session restore, or main-menu entry affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/main_menu.md` — update when boot flow affects menu entry, guest/login state, or startup navigation.
> - `docs/game_flow/game_state_map.md` — update when boot state, startup transitions, or scene/state ownership changes.
> - `docs/systems/auth_system.md` — update when guest login, session restore, refresh recovery, or auth startup behavior changes.
> - `docs/systems/main_scene_controller.md` — update when startup scene coordination, initial scene ownership, or prototype boot behavior changes.
> - `docs/systems/ui_system.md` — update when boot/loading UI, startup error UI, auth UI, or main-menu UI changes.
>
> Do not update this document in isolation when boot flow changes affect auth, main menu, game state, UI, release scope, or sprint tasks.

---

# Purpose

This document describes the intended boot flow for AltarSky.

Boot flow explains what happens from app launch until the player reaches a usable starting state, such as the main menu or a future home/sanctuary scene.

---

# Current Direction

Current boot flow should support:

- Launching the game.
- Initializing core scenes/systems.
- Loading or creating an auth session.
- Recovering a guest session if possible.
- Falling back to guest login when needed.
- Entering the main menu or prototype gameplay entry point.

---

# Intended Boot Sequence

Current intended high-level flow:

~~~text
App Launch
→ Core systems initialize
→ Auth/session load begins
→ Saved session found?
  → Yes: validate/refresh if needed
  → No: create guest session
→ Auth/session ready
→ Main Menu
→ Play session can begin
~~~

---

# Auth Relationship

Boot flow depends on the Auth System.

The auth system currently supports:

- Guest login
- Device fingerprinting
- JWT storage
- Refresh token storage
- Session persistence
- Automatic token refresh
- Session recovery on startup

Boot flow should not duplicate auth logic.

It should route through the Auth System and respond to auth readiness or failure states.

See:

- `docs/systems/auth_system.md`

---

# Main Menu Relationship

The main menu is the expected first player-facing destination after boot once menu flow exists.

Boot should eventually route into:

~~~text
Boot
→ Auth/session ready
→ Main Menu
~~~

Temporary prototype flows may jump directly into gameplay, but the intended release flow should preserve main-menu entry.

See:

- `docs/game_flow/main_menu.md`

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 boot goals:

- Game launches successfully.
- Auth/session behavior does not block play.
- Guest account creation works.
- Session persistence/recovery is verified.
- Player can reach main menu or temporary prototype entry point.
- Startup errors are not silent if they block play.

Deferrable:

- Full loading screen.
- Full login/register UI.
- Full account recovery UI.
- Full home/sanctuary boot destination.
- Full offline-mode handling.

---

# Open Questions

- Should Pre-Alpha 0.1 boot to main menu or temporary gameplay scene first?
- When should home/sanctuary become a boot destination?
- What UI should appear during guest login/session restore?
- What should happen if the backend is unreachable?
- Should auth failure block gameplay in early prototype builds?

---

# Final Rule

Boot flow should get the player safely from app launch to the intended starting state without hiding auth/session failures or confusing the release flow.
