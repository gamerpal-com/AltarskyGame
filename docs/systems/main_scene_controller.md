# Main Scene Controller

## Purpose

The Main Scene Controller manages the current prototype's top-level gameplay scene.

It is responsible for coordinating:

- Camera zoom levels
- Player screen bounds
- Player start position
- Horizontal zone splits
- Debug zone visibility
- UI button hookups
- UI label updates

This script acts as the central controller for the current playable prototype scene.

---

## Primary File

```text
scripts/_core/_main.gd
Scene Context

The controller is attached to the main gameplay scene root.

Current main scene structure:

Main
├── CanvasLayer_Background
│   └── SkySystem
├── AuthService
├── UI
├── ZoneOverlay
├── Player
└── Camera2D
Camera Zoom System

The controller defines multiple camera zoom levels for gameplay testing and future combat tuning.

Current zoom levels:

1.0x
1.5x
2.0x
2.5x
3.0x

The default startup zoom is:

1.5x

Zoom cycling is triggered through the UI zoom button.

The system supports future expansion for:

Boss fight zooms
Cinematic zooms
Exploration zooms
Event-driven zoom changes
Clamp Margin System

Each zoom level has its own player clamp margins.

These margins prevent the player from moving too far offscreen and allow each zoom level to have a different playable area.

Margin profiles exist for:

1.0x
1.5x
2.0x
2.5x
3.0x

The controller applies the correct margin profile based on the active zoom index.

Player Snap System

When the game starts or the zoom changes, the controller snaps the player to a bottom-centered position.

Each zoom level can have its own snap offset.

This keeps player placement consistent across camera zoom levels.

Zone Split System

The screen is divided into three horizontal zones:

LEFT
MIDDLE
RIGHT

Each zoom level can define different left/right split values.

The player reports zone changes back to the controller, and the controller updates the UI/debug display.

UI Integration

The controller connects to the main UI scene and listens for:

Zoom button pressed
Debug toggle button pressed

It also updates:

Current zoom label
Current zone label
Debug visibility state
Debug Features

The controller can toggle debug zone visibility.

Debug output is sent through the global logger when:

Player start zone is detected
Player changes zones
Zoom level changes
Debug visibility changes
Current Responsibilities

The Main Scene Controller currently owns:

Camera zoom setup
Camera zoom tweening
Player bounds configuration
Player snap offset selection
Zone split configuration
UI signal connection
Debug zone visibility
Future Notes

This controller should remain focused on scene coordination.

As the project grows, specialized systems should be moved out into their own controllers instead of expanding this script indefinitely.

Possible future extractions:

CameraController
ZoneManager
DebugOverlayManager
RunStateController
SceneStateController
