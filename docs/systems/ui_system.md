# UI System

## Purpose

The UI System manages the current prototype's player-facing interface elements.

It is responsible for displaying and controlling:

- Zoom status
- Zone status
- Debug visibility controls
- Debug panel visibility
- UI button signals

This system is currently focused on prototype/debug interaction rather than final gameplay UI.

---

## Primary Files

```text
scenes/UI_Main.tscn
scripts/ui/UI.gd
scripts/ui/zoom_button.gd
scripts/ui/debug_button.gd
Scene Context

The UI scene is instanced into the main gameplay scene.

Current relationship:

Main
└── UI

The Main Scene Controller communicates with the UI to:

Update zoom labels
Update zone labels
Toggle debug visibility
Listen for button presses
Current UI Responsibilities

The UI currently owns:

Zoom label display
Zone label display
Zoom button signal
Debug button signal
Debug panel visibility coordination
Zoom UI

The zoom UI allows the current camera zoom level to be displayed and cycled.

The UI exposes a zoom button signal that the Main Scene Controller connects to.

Flow:

Player presses zoom button
↓
UI emits zoom_button_pressed
↓
Main Scene Controller cycles zoom level
↓
UI label updates to show new zoom
Zone UI

The zone UI displays the player's current horizontal screen zone.

Current zones:

LEFT
MIDDLE
RIGHT

The Main Scene Controller updates the zone label when the Player emits a zone change signal.

Debug Toggle UI

The debug toggle allows debug visuals to be shown or hidden.

Current debug behavior:

Toggle zone overlay visibility
Toggle debug panel visibility
Log debug visibility state
Button Scripts

The UI currently uses small helper scripts for individual buttons.

Current button scripts:

scripts/ui/zoom_button.gd
scripts/ui/debug_button.gd

These scripts keep button-specific behavior separated from the main UI controller.

Prototype Status

The current UI is primarily a development/testing interface.

It is not final gameplay HUD design.

Current UI exists to support:

Camera testing
Zone testing
Debug visibility
Player movement testing
Prototype verification
Future Expansion

Future UI systems may include:

Health display
Mana display
Score display
Skill buttons
Pause menu
Inventory UI
Home menu UI
Settings menu
Boss health bars
Combat alerts
Mobile touch ability buttons

As the UI grows, it may need to be separated into dedicated UI controllers:

HUDController
PauseMenuController
InventoryUIController
HomeUIController
SettingsUIController
DebugUIController
