# Player Controller

## Purpose

The Player Controller manages the current playable character behavior for the ALTARSKY prototype.

It is responsible for:

- Player movement
- Mouse drag input
- Mobile touch input
- Keyboard movement
- Screen boundary clamping
- Horizontal zone detection
- Basic player shooting
- Placeholder special input handling

---

## Primary File

```text
scripts/gameplay/Player.gd
Scene Context

The player exists as an instanced scene inside the main gameplay scene.

Current related scene:

scenes/player.tscn

The player is coordinated by:

scripts/_core/_main.gd

The Main Scene Controller provides:

Camera reference
Clamp margin values
Zone split values
Starting snap position
Movement System

The player supports multiple control methods for prototype testing.

Current supported movement methods:

Mouse drag
Mobile touch drag
Keyboard movement

The controller tracks whether the player is actively dragging or moving.

When movement occurs, the player position is clamped to the visible gameplay area.

Mouse Drag Controls

On desktop, holding the left mouse button enables drag movement.

When dragging begins:

Drag state is enabled
Shooting state is enabled
Mouse cursor is confined and hidden
Drag offset is calculated so the player does not snap directly to the cursor

When dragging ends:

Drag state is disabled
Shooting state is disabled
Mouse cursor becomes visible again
Mobile Touch Controls

On mobile, screen touch input enables player dragging.

The system tracks active touch IDs to support future multi-touch behavior.

Current touch behavior:

Touch press begins movement
Touch drag moves the player
Touch release ends movement if no active touches remain

The system also tracks two-finger tap input for future special abilities.

Keyboard Controls

When the player is not dragging, keyboard movement is available.

Current movement input actions:

move_left
move_right
move_up
move_down

Keyboard direction is normalized so diagonal movement does not become faster than horizontal or vertical movement.

Screen Clamp System

The player position is restricted to the visible screen area.

Clamp boundaries are calculated using:

Current camera position
Current camera zoom
Viewport size
Active margin profile

The Main Scene Controller updates the margin profile depending on the active zoom level.

This prevents the player from moving too far offscreen at different camera zooms.

Snap To Bottom Center

The player can be snapped to a bottom-centered gameplay position.

This is used:

On game start
When zoom levels change

The snap position uses the current camera zoom and active bottom offset.

This keeps the player in a consistent playable location across zoom levels.

Zone Detection

The screen is divided into three horizontal zones:

LEFT
MIDDLE
RIGHT

The player calculates its current zone based on:

Camera position
Camera zoom
Visible screen width
Zone split values

When the player enters a new zone, it emits:

zone_changed(old_zone, new_zone)

The Main Scene Controller listens to this signal and updates the UI/debug display.

Shooting System

The player currently has a basic automatic shooting system.

Shooting begins when the player is actively moving or dragging.

Current shooting behavior:

Instantiates a bullet scene
Fires upward
Applies configurable bullet speed
Applies configurable bullet lifetime
Applies configurable bullet scale
Limits shots per second

Current bullet scene is assigned through the Godot Inspector.

Special Input Placeholders

The controller includes placeholder logic for special ability input.

Current special input methods:

Two-finger tap on mobile
Spacebar tap on desktop

Current placeholder outputs:

SPECIAL 1
SPECIAL 2

These currently log through the global logger.

Future systems can replace these placeholders with:

Bomb attacks
Mana skills
Dash abilities
Defensive abilities
Ultimate abilities
Current Responsibilities

The Player Controller currently owns:

Player movement
Input handling
Drag behavior
Touch tracking
Screen clamping
Zone detection
Bullet spawning
Basic fire rate limiting
Special input placeholders
Future Notes

This controller should remain focused on direct player behavior.

As the project grows, some responsibilities may be moved into dedicated systems.

Possible future extractions:

PlayerInputController
PlayerMovementController
PlayerWeaponController
PlayerAbilityController
PlayerStatsController
PlayerAnimationController
