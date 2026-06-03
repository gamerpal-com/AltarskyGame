# UI System

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
