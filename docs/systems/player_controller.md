# Player Controller

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if player-controller responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if player-controller work changes Developer Hat, QA Hat, Art Director Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when player-controller tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if player movement, soul core implementation, hitbox behavior, or player-control readiness affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/gameplay.md` — update when player movement, damage handling, shooting, soul-core hitbox behavior, or gameplay flow changes.
> - `docs/game_flow/game_state_map.md` — update when player state, damage state, death triggering, pause behavior, or sanctuary return transitions change.
> - `docs/systems/player_soul_core.md` — update when player body/core ownership, true hitbox behavior, damage handling, death triggering, or player readability changes.
> - `docs/systems/projectile_system.md` — update when player shooting, bullet spawning, projectile ownership, or projectile/core collision behavior changes.
> - `docs/systems/ui_system.md` — update when player state affects HUD, debug UI, zone UI, death/result UI, or gameplay overlays.
>
> Do not update this document in isolation when player behavior changes affect the soul core, projectile behavior, gameplay flow, UI, or release scope.

---

## Purpose

The Player Controller manages the current playable character behavior for the AltarSky prototype.

It is responsible for:

- Player movement
- Mouse drag input
- Mobile touch input
- Keyboard movement
- Screen boundary clamping
- Horizontal zone detection
- Basic player shooting
- Placeholder special input handling
- Future soul core positioning / hitbox coordination

---

## Primary File

```text
scripts/gameplay/Player.gd
```

Current related scene:

```text
scenes/player.tscn
```

The player is coordinated by:

```text
scripts/_core/_main.gd
```

---

## Scene Context

The player exists as an instanced scene inside the main gameplay scene.

The Main Scene Controller provides:

- Camera reference
- Clamp margin values
- Zone split values
- Starting snap position

---

## Movement System

The player supports multiple control methods for prototype testing.

Current supported movement methods:

- Mouse drag
- Mobile touch drag
- Keyboard movement

The controller tracks whether the player is actively dragging or moving.

When movement occurs, the player position is clamped to the visible gameplay area.

---

## Mouse Drag Controls

On desktop, holding the left mouse button enables drag movement.

When dragging begins:

- Drag state is enabled.
- Shooting state is enabled.
- Mouse cursor is confined and hidden.
- Drag offset is calculated so the player does not snap directly to the cursor.

When dragging ends:

- Drag state is disabled.
- Shooting state is disabled.
- Mouse cursor becomes visible again.

---

## Mobile Touch Controls

On mobile, screen touch input enables player dragging.

The system tracks active touch IDs to support future multi-touch behavior.

Current touch behavior:

- Touch press begins movement.
- Touch drag moves the player.
- Touch release ends movement if no active touches remain.

The system also tracks two-finger tap input for future special abilities.

---

## Keyboard Controls

When the player is not dragging, keyboard movement is available.

Current movement input actions:

- `move_left`
- `move_right`
- `move_up`
- `move_down`

Keyboard direction is normalized so diagonal movement does not become faster than horizontal or vertical movement.

---

## Screen Clamp System

The player position is restricted to the visible screen area.

Clamp boundaries are calculated using:

- Current camera position
- Current camera zoom
- Viewport size
- Active margin profile

The Main Scene Controller updates the margin profile depending on the active zoom level.

This prevents the player from moving too far offscreen at different camera zooms.

---

## Snap To Bottom Center

The player can be snapped to a bottom-centered gameplay position.

This is used:

- On game start
- When zoom levels change

The snap position uses the current camera zoom and active bottom offset.

This keeps the player in a consistent playable location across zoom levels.

---

## Zone Detection

The screen is divided into three horizontal zones:

- LEFT
- MIDDLE
- RIGHT

The player calculates its current zone based on:

- Camera position
- Camera zoom
- Visible screen width
- Zone split values

When the player enters a new zone, it emits:

```text
zone_changed(old_zone, new_zone)
```

The Main Scene Controller listens to this signal and updates the UI/debug display.

---

## Shooting System

The player currently has a basic automatic shooting system.

Shooting begins when the player is actively moving or dragging.

Current shooting behavior:

- Instantiates a bullet scene.
- Fires upward.
- Applies configurable bullet speed.
- Applies configurable bullet lifetime.
- Applies configurable bullet scale.
- Limits shots per second.

Current bullet scene is assigned through the Godot Inspector.

Long-term, player bullet spawning should move out of the Player Controller and into a dedicated Projectile System.

See:

- `docs/systems/projectile_system.md`

---

## Soul Core / Hitbox Direction

The Player Controller must eventually coordinate the player body and player soul core as separate concepts.

The player body is the visible astral projection.

The soul core is the true player from a gameplay/readability perspective.

The soul core is the true hitbox.

Player Controller responsibilities may eventually include:

- Owning or referencing the soul core node.
- Keeping the soul core aligned to the intended hitbox center.
- Ensuring movement moves the body and core together.
- Ensuring screen clamping is based on the gameplay-relevant player position.
- Routing damage/death events through the soul core.
- Supporting core-only debug/combat testing.
- Keeping body/core separation clear for animation and VFX.

The player body, wings, clothing, and animation should not become the primary bullet collision target.

Enemy projectile collision should be tuned around the soul core.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`

---

## Damage / Death Direction

When the soul core is hit:

1. Damage should be applied through the soul core / true hitbox.
2. The player body may visually destabilize.
3. If the player survives, the projection stabilizes.
4. If the hit is fatal, the soul-core death sequence begins.

The Player Controller may eventually need to communicate with:

- PlayerSoulCore
- PlayerDamageVFX
- PlayerDeathVFX
- Game state / flow controller
- UI result popup system
- Home/sanctuary transition flow

Death should eventually route through:

```text
Gameplay
→ Fatal hit to soul core
→ Death sequence
→ Sanctuary / Home
→ Results / Loss Popup
```

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/game_state_map.md`
- `docs/game_flow/home.md`

---

## Special Input Placeholders

The controller includes placeholder logic for special ability input.

Current special input methods:

- Two-finger tap on mobile
- Spacebar tap on desktop

Current placeholder outputs:

- SPECIAL 1
- SPECIAL 2

These currently log through the global logger.

Future systems can replace these placeholders with:

- Bomb attacks
- Mana skills
- Dash abilities
- Defensive abilities
- Ultimate abilities

---

## Current Responsibilities

The Player Controller currently owns:

- Player movement
- Input handling
- Drag behavior
- Touch tracking
- Screen clamping
- Zone detection
- Bullet spawning
- Basic fire rate limiting
- Special input placeholders

---

## Future Notes

This controller should remain focused on direct player behavior.

As the project grows, some responsibilities may be moved into dedicated systems.

Possible future extractions:

- PlayerInputController
- PlayerMovementController
- PlayerWeaponController
- PlayerAbilityController
- PlayerStatsController
- PlayerAnimationController
- PlayerSoulCore
- PlayerDamageController
