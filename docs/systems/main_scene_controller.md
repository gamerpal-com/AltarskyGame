# Main Scene Controller

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if main-scene-controller responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if main-scene work changes Developer Hat, QA Hat, Documentation Architect Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when main-scene tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if scene coordination, camera/zoom, UI hookups, player setup, or gameplay readiness affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/boot_flow.md` — update when startup scene flow, auth startup, or initial scene loading changes.
> - `docs/game_flow/gameplay.md` — update when main-scene behavior affects active gameplay, player setup, camera/zoom behavior, or play-session flow.
> - `docs/game_flow/game_state_map.md` — update when scene/state ownership, pause/death/sanctuary transitions, or future state flow changes.
> - `docs/systems/player_controller.md` — update when main-scene player setup, clamp margins, snap behavior, or camera references change.
> - `docs/systems/ui_system.md` — update when main-scene UI hookups, debug UI, zoom UI, or zone UI interactions change.
> - `docs/systems/sky_lighting_system.md` — update when main-scene ownership or placement of sky lighting changes.
> - `docs/systems/skyflow_director.md` — update when main-scene ownership or placement of sky/environment systems changes.
>
> Do not update this document in isolation when scene coordination changes affect player behavior, UI, sky systems, game flow, release scope, or sprint tasks.

---

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
- Scene-level prototype coordination

This script acts as the central controller for the current playable prototype scene.

---

## Primary File

```text
scripts/_core/_main.gd
```

---

## Scene Context

The controller is attached to the main gameplay scene root.

Current main scene structure:

```text
Main
├── CanvasLayer_Background
│   └── SkySystem
├── AuthService
├── UI
├── ZoneOverlay
├── Player
└── Camera2D
```

---

## Camera Zoom System

The controller defines multiple camera zoom levels for gameplay testing and future combat tuning.

Current zoom levels:

- 1.0x
- 1.5x
- 2.0x
- 2.5x
- 3.0x

The default startup zoom is:

```text
1.5x
```

Zoom cycling is triggered through the UI zoom button.

The system supports future expansion for:

- Boss fight zooms
- Cinematic zooms
- Exploration zooms
- Event-driven zoom changes

---

## Clamp Margin System

Each zoom level has its own player clamp margins.

These margins prevent the player from moving too far offscreen and allow each zoom level to have a different playable area.

Margin profiles exist for:

- 1.0x
- 1.5x
- 2.0x
- 2.5x
- 3.0x

The controller applies the correct margin profile based on the active zoom index.

---

## Player Snap System

When the game starts or the zoom changes, the controller snaps the player to a bottom-centered position.

Each zoom level can have its own snap offset.

This keeps player placement consistent across camera zoom levels.

---

## Zone Split System

The screen is divided into three horizontal zones:

- LEFT
- MIDDLE
- RIGHT

Each zoom level can define different left/right split values.

The player reports zone changes back to the controller, and the controller updates the UI/debug display.

---

## UI Integration

The controller connects to the main UI scene and listens for:

- Zoom button pressed
- Debug toggle button pressed

It also updates:

- Current zoom label
- Current zone label
- Debug visibility state

---

## Debug Features

The controller can toggle debug zone visibility.

Debug output is sent through the global logger when:

- Player start zone is detected.
- Player changes zones.
- Zoom level changes.
- Debug visibility changes.

---

## Player / Soul Core Relationship

The Main Scene Controller does not own final soul-core gameplay logic, but scene-level coordination may affect soul-core readability.

Main-scene responsibilities may eventually include:

- Ensuring the player scene is instanced correctly.
- Ensuring the camera/zoom setup does not hide the soul core.
- Ensuring player clamp/snap behavior aligns with the true gameplay position.
- Ensuring UI/debug overlays do not permanently obscure gameplay readability.
- Coordinating future death/sanctuary transition triggers if no dedicated state controller exists yet.

See:

- `docs/systems/player_soul_core.md`
- `docs/systems/player_controller.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/game_state_map.md`

---

## Sky System Relationship

The main scene currently owns or instances the sky background system.

Sky systems should remain visually behind gameplay.

The main scene should preserve the intended readability hierarchy:

```text
UI
Player soul core
Enemy projectiles
Player/body/bullets/enemies
Sky/environment layers
```

See:

- `docs/systems/sky_lighting_system.md`
- `docs/systems/skyflow_director.md`
- `docs/systems/sky_depth_system.md`

---

## Current Responsibilities

The Main Scene Controller currently owns:

- Camera zoom setup
- Camera zoom tweening
- Player bounds configuration
- Player snap offset selection
- Zone split configuration
- UI signal connection
- Debug zone visibility
- Scene-level prototype coordination

---

## Future Notes

This controller should remain focused on scene coordination.

As the project grows, specialized systems should be moved out into their own controllers instead of expanding this script indefinitely.

Possible future extractions:

- CameraController
- ZoneManager
- DebugOverlayManager
- RunStateController
- SceneStateController
- GameStateManager
- DeathTransitionController

---

# Final Rule

The Main Scene Controller should coordinate the prototype scene without becoming the permanent owner of every gameplay system.

As systems mature, responsibilities should move into dedicated controllers.
