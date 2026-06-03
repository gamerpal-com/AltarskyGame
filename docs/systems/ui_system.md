# UI System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if UI-system responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if UI work changes Developer Hat, QA Hat, Art Director Hat, Documentation Architect Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when UI tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if UI behavior, debug UI, HUD, results popup, or menu flow affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/gameplay.md` — update when gameplay UI, HUD, score display, death UI, or pause/gameplay overlays change.
> - `docs/game_flow/home.md` — update when sanctuary UI, post-death result popup, preparation UI, or recovery UI changes.
> - `docs/game_flow/game_state_map.md` — update when UI affects state transitions, death results, pause, menu, or sanctuary flow.
> - `docs/systems/player_soul_core.md` — update when UI layers, death result popup, gameplay readability, or soul-core visibility rules change.
> - `docs/systems/player_controller.md` — update when UI depends on player state, zone state, movement state, or player death/recovery state.
> - `docs/systems/projectile_system.md` — update when UI affects projectile/debug visualization, score display, or combat readability.
>
> Do not update this document in isolation when UI behavior changes affect gameplay state, soul core visibility, death/sanctuary flow, projectile readability, or release scope.

## Purpose

The UI System manages the current prototype's player-facing and developer-facing interface elements.

It is responsible for displaying and controlling:

- Zoom status
- Zone status
- Debug visibility controls
- Debug panel visibility
- Debug log filter controls
- Mobile-friendly debug buttons
- UI button signals

This system is currently focused on prototype/debug interaction rather than final gameplay UI.

---

## Core Rule

The UI should support testing without interfering with gameplay.

Prototype UI can be simple, but it should stay organized enough that future gameplay UI can grow without becoming tangled with debug-only systems.

---

## Primary Files

```text
scenes/UI_Main.tscn
scripts/ui/UI.gd
scripts/ui/zoom_button.gd
scripts/ui/debug_button.gd
scripts/ui/DebugPanel.gd
scripts/ui/ZoneOverlay.gd
```

---

## Scene Context

The UI scene is instanced into the main gameplay scene.

Current relationship:

```text
Main
└── UI_Main
```

The Main Scene Controller communicates with the UI to:

- Update zoom labels
- Update zone labels
- Toggle debug visibility
- Listen for button presses
- Display runtime debug information

---

## Current UI Responsibilities

The UI currently owns:

- Zoom label display
- Zone label display
- Zoom button signal
- Debug button signal
- Debug panel visibility coordination
- Debug filter button display
- Mobile-friendly debug controls
- Prototype development diagnostics

---

## Zoom UI

The zoom UI allows the current camera zoom level to be displayed and cycled.

The UI exposes a zoom button signal that the Main Scene Controller connects to.

Flow:

```text
Player presses zoom button
↓
UI emits zoom_button_pressed
↓
Main Scene Controller cycles zoom level
↓
UI label updates to show new zoom
```

---

## Zone UI

The zone UI displays the player's current horizontal screen zone.

Current zones:

- LEFT
- MIDDLE
- RIGHT

The Main Scene Controller updates the zone label when the Player emits a zone change signal.

The zone UI exists to help test:

- Player screen position
- Camera behavior
- Zone-based logic
- Future spawn-zone behavior

---

## Debug Toggle UI

The debug toggle allows debug visuals and debug tools to be shown or hidden.

Current debug behavior:

- Toggle zone overlay visibility
- Toggle debug panel visibility
- Toggle debug filter controls
- Help inspect runtime systems
- Support prototype performance testing

The debug toggle should remain accessible during development but should not permanently occupy too much screen space.

---

## Debug Filter Controls

The debug panel now includes filter controls for the in-game logger.

Current controls:

- Refresh
- All
- Live
- Errors
- Warn
- System
- Info
- Verb

### Refresh

Reloads the current filtered log snapshot.

This is not a toggle.

### All

Shows all log levels.

### Live

Allows visible logs to update while the debug console is open.

Live mode is off by default to protect gameplay performance.

### Errors

Shows or hides `ERROR` logs.

### Warn

Shows or hides `WARNING` logs.

### System

Shows or hides `SYSTEM` logs.

### Info

Shows or hides `INFO` logs.

### Verb

Shows or hides `VERBOSE` logs.

---

## Debug Filter Default State

Recommended default state:

- Errors: ON
- Warnings: ON
- System: ON
- Info: OFF
- Verbose: OFF
- All: OFF
- Live: OFF

This keeps important information visible while hiding noisy logs.

---

## Mobile Debug UI Notes

The debug controls are designed to be usable on mobile.

Mobile debug buttons should use:

- Large touch targets
- Clear ON/OFF labels
- Obvious pressed/toggled visual state
- Enough spacing between controls

Refresh should remain a normal button.

All other debug filter buttons should be toggle buttons.

This is important because finger taps are less precise than mouse clicks.

---

## Debug Panel Performance Notes

The debug UI should never hurt gameplay performance.

The Debug Panel uses a performance-safe display model:

- Hidden console does no visual work.
- Logs do not rebuild the UI every time they arrive.
- Snapshot display is the default.
- Live display is optional.
- Visible logs are filtered.
- Visible log count is capped.
- Log loading can happen progressively.

The UI system should preserve this behavior when future debug controls are added.

---

## Button Scripts

The UI currently uses small helper scripts for individual buttons.

Current button scripts:

```text
scripts/ui/zoom_button.gd
scripts/ui/debug_button.gd
```

These scripts keep button-specific behavior separated from the main UI controller.

---

## Prototype Status

The current UI is primarily a development/testing interface.

It is not final gameplay HUD design.

Current UI exists to support:

- Camera testing
- Zone testing
- Debug visibility
- Debug log filtering
- Player movement testing
- Prototype verification
- Performance investigation

---

## Future Expansion

Future UI systems may include:

- Health display
- Mana display
- Score display
- Skill buttons
- Pause menu
- Inventory UI
- Home menu UI
- Settings menu
- Boss health bars
- Combat alerts
- Mobile touch ability buttons
- Between-round soft break UI
- Biome change item UI
- Pet status UI

---
---

## Soul Core / Gameplay UI Relationship

UI sits above the soul core in the visual hierarchy.

Current intended hierarchy:

```text
Layer 2: Scene camera UI
Layer 1: UI
Layer 0: Player soul core / true hitbox marker
Layer -1: Enemy projectiles
Layer -2 and below: player body, bullets, enemies, environment, sky
```

During active gameplay, UI should not unnecessarily obscure the soul core or enemy projectiles.

UI may cover the soul core during:

- Menus
- Pause
- Debug overlays
- Post-death result popups
- Sanctuary/home flow
- Scene transitions

The soul core remains the top gameplay visual anchor, but UI can sit above it when the game state calls for an interface overlay.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/game_state_map.md`

---

## Death Results / Sanctuary Popup Direction

The post-death results/loss popup should appear after the soul-core death sequence and sanctuary return.

Intended flow:

```text
Fatal hit to soul core
→ Death sequence
→ Fade out
→ Sanctuary / Home
→ Player wakes / reforms / stabilizes
→ Results / Loss Popup
```

The popup should eventually display:

- Score
- Losses
- Rank damage
- Items lost
- Temporary upgrades lost
- Rewards preserved
- Next preparation options

This popup should not appear before the death cinematic completes.

See:

- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`


## Future UI Separation

As the UI grows, it may need to be separated into dedicated UI controllers:

- `HUDController`
- `PauseMenuController`
- `InventoryUIController`
- `HomeUIController`
- `SettingsUIController`
- `DebugUIController`
- `SoftBreakUIController`
- `PetUIController`

The current UI system is acceptable for prototype development, but final systems should be separated once gameplay UI becomes more complex.

---

## Long-Term Goal

The UI System should support prototype testing now while leaving room for final gameplay UI later.

Debug UI and gameplay UI should eventually be separated so developer tools can be hidden, disabled, or removed from release builds without disrupting the player-facing interface.
