# Skyflow Director / Sky Layer Manager

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if Skyflow Director responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if sky/environment work changes Developer Hat, QA Hat, Art Director Hat, Documentation Architect Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when Skyflow/Sky Layer Manager tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if sky-world depth, layer behavior, readability, or environmental completion affects Pre-Alpha 0.1 scope.
> - `docs/systems/sky_depth_system.md` — update when depth layers, cosmetic/gameplay boundary, parallax behavior, or readability hierarchy changes.
> - `docs/systems/sky_lighting_system.md` — update when lighting, time-of-day color, atmospheric tinting, or visual dimming affects sky layers.
> - `docs/systems/player_soul_core.md` — update when sky/environment readability affects soul-core visibility, gameplay layer priority, or projectile/core readability.
> - `docs/systems/projectile_system.md` — update when sky/environment visuals affect projectile readability, enemy bullet visibility, or bullet/background separation.
> - `docs/game_flow/gameplay.md` — update when environment behavior affects gameplay readability, combat flow, or player survival readability.
> - `docs/planning/sky_time_map.md` — update when sky time-of-day, lighting phase, biome/time, or environmental-cycle planning changes.
>
> Do not update this document in isolation when sky/environment behavior affects player readability, projectile readability, lighting, depth hierarchy, gameplay flow, or release scope.

---

# Purpose

This document describes the Skyflow Director / Sky Layer Manager direction.

The current active implementation is the Sky Layer Manager.

Skyflow Director is the future orchestration layer that should coordinate environmental streaming, layer behavior, player corridor protection, depth rules, and world-scale sky presentation.

The goal is to make AltarSky feel like a layered moving sky world, not a flat background.

---

# Current Sprint Context

Current sprint:

```text
Sky Layer Manager Depth & Lighting
```

Current branch:

```text
feature/pre-alpha-0.1-sky-layer-manager-depth-lighting
```

Current focus:

- Layered sky/cloud/island system
- Dynamic spawning and recycling
- Spawn distribution and jitter
- Anti-stacking protection
- ScreenZoneHelper support
- Side-aware / inward drift
- Per-asset movement controls
- Inspector-driven tuning
- Player corridor readability
- Atmospheric clouds
- Terrain-like islands below/around player
- Open bullet-hell readability around the player

---

# Core Visual Goal

The sky should feel like a layered moving world.

The player should feel like they are flying forward above islands and through atmospheric sky layers.

The environment should create motion and scale while the player remains readable and central.

Good direction:

- Behind-and-above forward flight
- Islands below or around the player
- Distant islands partially obscured by clouds
- Clouds moving naturally like atmosphere/weather
- Large upper/front clouds for depth
- Distant layers with subtle atmospheric loss
- Open space around the player for bullet-hell readability

Avoid:

- Flat wallpaper background
- Orthographic/platformer-like environment perspective
- Sky layers that overpower the player
- Clouds/islands that fill the player corridor too aggressively
- Background sparkles that compete with the soul core
- Environment motion that makes bullet dodging unreadable

---

# Skyflow Director Responsibility

The future Skyflow Director should coordinate:

- Layered world streaming
- Spawn management
- Player flight corridor protection
- Atmospheric depth simulation
- Environmental motion
- Performance-oriented streaming
- Biome/time-of-day hooks
- Sky Layer Manager configuration
- Layer readability filtering
- Future environmental effects

It should not replace the Sky Layer Manager immediately.

Skyflow Director should build on top of the Sky Layer Manager once the current Sky Layer Manager MVP is stable.

---

# Current Sky Layer Manager Responsibilities

The current Sky Layer Manager is responsible for:

- Spawning sky/environment assets
- Recycling assets after they exit useful bounds
- Managing layer movement
- Applying per-layer and per-asset drift rules
- Controlling spawn distribution
- Avoiding asset stacking
- Respecting player corridor readability
- Supporting clouds and islands as different environmental behaviors
- Exposing tuning values through the Godot Inspector

Current supported environmental categories:

- Clouds
- Floating islands
- Sky/world background layers

Future categories may include:

- Fog
- Debris
- Atmospheric particles
- Flying creatures
- Weather effects
- Environmental VFX

---

# Player Corridor Rule

The player corridor is the readable gameplay space around the player.

The Sky Layer Manager should protect this corridor.

Purpose:

- Keep the soul core readable.
- Keep enemy projectiles readable.
- Keep bullet-hell dodging fair.
- Prevent sky assets from hiding gameplay objects.
- Preserve mobile screen clarity.

The environment may pass around the player, behind the player, or partially near the player, but it should not destroy the visual relationship between:

- Soul core = where I am.
- Enemy projectiles = what can kill me.

See:

- `docs/systems/player_soul_core.md`
- `docs/systems/projectile_system.md`
- `docs/game_flow/gameplay.md`

---

# Soul Core / Environment Readability Rule

The player soul core is the highest-priority gameplay visual.

Sky/environment layers are cosmetic or atmospheric unless intentionally promoted into gameplay.

Skyflow/Sky Layer Manager must respect the gameplay visual hierarchy.

Rules:

- Sky layers must not hide the soul core.
- Clouds must not obscure the soul core during active gameplay unless explicitly used for a designed effect.
- Islands must not create visual clutter near the core.
- Background sparkles must not mimic the soul core's rapid RGB center sparkle.
- Environmental VFX must not look like enemy projectiles.
- Sky layers must not hide enemy projectiles.
- Cosmetic layers should remain visually lower priority than the gameplay stack.

If an environment asset competes with the soul core or enemy projectiles, tune:

- Opacity
- Brightness
- Contrast
- Saturation
- Speed
- Spawn spacing
- Player corridor buffer
- Layer depth
- Render order
- Atmospheric filter
- Visual intensity

---

# Cloud Behavior

Clouds represent atmosphere, weather, and living sky motion.

Clouds should feel like moving environmental atmosphere.

Cloud requirements:

- Horizontal drift enabled
- Spawn-zone awareness enabled
- Speed variation allowed
- Future rotation support possible
- Multiple depth passes supported
- Natural flow through sky
- Tunable density
- Tunable opacity / readability

Clouds may move more freely than islands.

Clouds should not feel like stable terrain.

Clouds should not overpower the soul core or enemy projectiles.

---

# Island Behavior

Islands represent terrain, landmarks, and world-scale sky geography.

Islands should feel massive, stable, and grounded.

Island requirements:

- Horizontal drift generally disabled or heavily controlled
- Terrain-like movement behavior
- Stable positioning
- Future streaming support
- Can enter partially from screen edges
- Can be partially obscured by clouds
- Should feel below/around the player, not like foreground hazards unless intentionally designed

Islands should not behave like weather.

Islands should not crowd the player corridor.

---

# Spawn Zone Awareness

Sky/environment assets may spawn outside visible screen bounds.

Zone detection must account for off-screen positions so side-aware drift works correctly.

Important requirement:

- ScreenZoneHelper needs an off-screen spawn patch/support for environmental assets.

Reason:

- Environmental assets can spawn before entering visible bounds.
- Side-aware drift may misclassify off-screen objects.
- Large islands/clouds may need correct inward drift before becoming visible.
- Player corridor readability depends on predictable spawn/drift behavior.

This is an active/open Sky Layer Manager concern.

---

# Movement Profiles

Layer behavior should be controlled through configuration rather than hardcoded logic whenever possible.

Movement profiles may include:

- Static / locked
- Slow drift
- Inward side drift
- Vertical scroll
- Forward-depth illusion
- Cloud flow
- Island terrain pass
- Fog pass-through
- Weather effect motion

Each layer should be able to tune:

- Base speed
- Direction
- Drift amount
- Randomness
- Spawn spacing
- Depth relationship
- Visual intensity
- Corridor avoidance

---

# Depth Relationship

Skyflow Director and the Sky Layer Manager should coordinate with the Sky Depth System.

Depth should communicate:

- Far background
- Distant islands
- Mid clouds
- Near clouds
- Foreground atmosphere
- Gameplay layer separation
- Cosmetic/background hierarchy

The environment should feel deep, but gameplay objects must remain readable.

See:

- `docs/systems/sky_depth_system.md`

---

# Lighting Relationship

Skyflow Director and Sky Layer Manager should coordinate with the Sky Lighting System.

Lighting may affect:

- Background color
- Cloud tint
- Island tint
- Atmospheric haze
- Horizon glow
- Time-of-day mood
- Scene dimming during death sequence

Lighting must not hide the soul core or enemy projectiles.

See:

- `docs/systems/sky_lighting_system.md`
- `docs/systems/player_soul_core.md`

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should focus on making the current Sky Layer Manager feel visually convincing and readable.

In scope:

- Per-asset drift controls
- Spawn-zone awareness
- Layer movement profiles
- Multi-layer cloud tuning
- Island layer tuning
- Zoom integration
- Lighting integration
- Environmental MVP review
- Performance review
- Remaining Sky Layer Manager blocker review
- Soul-core/projectile readability preservation over sky layers

Out of scope unless needed:

- Full Skyflow Director replacement
- Full biome system
- Full weather system
- Full scene map documentation
- Large-scale environmental AI
- Final production sky art polish

---

# QA / Validation Checklist

Validate:

- Clouds feel atmospheric and alive.
- Islands feel stable and terrain-like.
- Sky layers create convincing scale.
- Player corridor remains readable.
- Soul core remains visible.
- Enemy projectiles remain visible.
- Player bullets do not overpower soul core/projectile readability.
- Background stars/sparkles do not mimic the soul core.
- Zoom changes do not break environmental presentation.
- Lighting changes do not hide gameplay.
- Idle/performance spikes are monitored in exported/runtime builds if visible.
- Off-screen spawn behavior is correct once added.

---

# Open Questions

- How much off-screen spawn padding should ScreenZoneHelper support?
- Should player corridor rules be per-layer, global, or both?
- Should cloud opacity vary by depth layer?
- Should islands ever enter the player corridor as hazards, or remain cosmetic for Pre-Alpha 0.1?
- How should zoom integration affect sky layer speed, scale, or density?
- Should Skyflow Director become a separate system in Pre-Alpha 0.1 or remain future architecture?

---

# Final Rule

The sky should feel alive.

The player should remain readable.

The soul core and enemy projectiles define the gameplay readability language.

The environment must support the game, not hide it.
