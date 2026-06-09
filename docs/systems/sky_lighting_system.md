# Sky Lighting System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if sky-lighting responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if lighting work changes Developer Hat, QA Hat, Art Director Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when sky-lighting tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if lighting, atmospheric rendering, player readability, or sky presentation affects Pre-Alpha 0.1 scope.
> - `docs/planning/sky_time_map.md` — update when time-of-day, lighting phase duration, biome/time, sky cycle, or day/night rules change.
> - `docs/systems/skyflow_director.md` — update when lighting affects sky layers, cloud/island tinting, environmental mood, or sky orchestration.
> - `docs/systems/sky_depth_system.md` — update when lighting affects depth filtering, cosmetic layer clarity, gameplay readability, or background/foreground separation.
> - `docs/systems/player_soul_core.md` — update when lighting, glow, dimming, death VFX, or visibility rules affect the soul core.
> - `docs/systems/ui_system.md` — update when lighting/dimming affects UI visibility, death result popup readability, or gameplay overlays.
>
> Do not update this document in isolation when lighting changes affect sky depth, player readability, soul core visibility, gameplay flow, UI, or release scope.

---

## Purpose

The Sky Lighting System controls AltarSky's current atmospheric lighting framework.

It is responsible for:

- Morning, Day, Sunset, and Night phase cycling
- Smooth sky color transitions
- Full-screen atmospheric gradient rendering
- Horizon glow rendering
- Player ambient tinting
- Camera-zoom independent sky display
- Future death-sequence scene dimming coordination
- Future time-of-day readability tuning

This system is the first version of AltarSky's environmental lighting framework.

---

## Primary Files

```text
scenes/SkySystem.tscn
scripts/gameplay/skycyclecontroller.gd
shaders/sky/SkyGradient.gdshader
```

---

## Scene Structure

The SkySystem scene currently contains:

```text
SkySystem
├── BackgroundColor
└── GradientOverlay
```

BackgroundColor is a full-screen ColorRect used as the base sky color.

GradientOverlay is a full-screen ColorRect using `SkyGradient.gdshader`.

---

## Main Scene Integration

The SkySystem is instanced into the main scene under a background CanvasLayer.

Current structure:

```text
Main
└── CanvasLayer_Background
	└── SkySystem
```

The CanvasLayer prevents the sky from being affected by Camera2D zoom.

This keeps the background full-screen and stable while gameplay zoom changes.

---

## Time Cycle

The system currently supports four lighting phases:

- Morning
- Day
- Sunset
- Night

Each phase has its own Inspector-exposed duration.

Current test values are short for rapid iteration.

Future production values should be tuned in:

```text
docs/planning/sky_time_map.md
```

---

## SkyCycleController

`SkyCycleController.gd` controls the runtime lighting cycle.

It tracks:

- `time_in_cycle`
- `morning_duration`
- `day_duration`
- `sunset_duration`
- `night_duration`

Each frame, the controller:

- Advances the cycle timer.
- Calculates the current phase blend.
- Updates the base sky color.
- Updates shader color parameters.
- Updates the player ambient tint.

---

## Gradient Shader

`SkyGradient.gdshader` creates the atmospheric gradient.

It uses runtime parameters for:

- `top_color`
- `middle_color`
- `horizon_color`
- `bottom_color`
- `horizon_position`
- `horizon_strength`

The shader creates:

- Upper atmosphere color
- Mid-atmosphere color
- Bright horizon band
- Lower atmosphere color
- Subtle horizon glow

---

## Player Ambient Tint

The system can tint the player based on the current time of day.

Current player tint phases:

- Morning
- Day
- Sunset
- Night

This helps the character visually belong to the environment.

The player reference is assigned through:

```text
player_path
```

in the Godot Inspector.

---

## Soul Core Visibility Rule

Lighting must never hide the soul core during active gameplay.

The player soul core is the highest-priority gameplay visual.

Lighting may tint the player body/projection, but the core must remain readable.

Lighting should not:

- Darken the core until it disappears.
- Over-saturate the background around the core.
- Create glow that competes with the core's rapid sparkle.
- Make background stars look like the soul core.
- Hide enemy projectiles.
- Make projectiles blend into clouds, sky, or horizon glow.

If a lighting phase hurts readability, tune:

- Sky brightness
- Contrast
- Saturation
- Horizon strength
- Player ambient tint strength
- Core glow compensation
- Projectile contrast
- Background star intensity

See:

- `docs/systems/player_soul_core.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/projectile_system.md`

---

## Death Sequence Lighting Direction

The player soul-core death sequence uses lighting/dimming as part of the cinematic flow.

Intended direction:

```text
Fatal hit to soul core
→ Glass-break sound
→ Generator power-down sound
→ Gameplay slow/freeze
→ Scene dim
→ Soul core destabilizes
→ Rays of light rupture outward
→ Astral projection vaporizes
→ Magical explosion
→ Fade out
→ Sanctuary / Home
```

The scene dim should support the death moment without making the soul core unreadable.

During the death sequence:

- Background/world can dim.
- Soul core rupture should remain visible.
- Light rays should be readable.
- Explosion should feel magical/soul-based.
- UI should remain hidden or controlled until the sanctuary result popup appears.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`

---

## Sky Depth / Lighting Relationship

Lighting should support the Sky Depth System.

Lighting can reinforce depth through:

- Atmospheric haze
- Time-of-day tint
- Horizon glow
- Cloud color modulation
- Island tinting
- Background dimming
- Night contrast
- Sunset warmth

Lighting should not remove gameplay clarity.

The cosmetic/background layers should remain lower priority than the gameplay stack.

See:

- `docs/systems/sky_depth_system.md`
- `docs/systems/skyflow_director.md`

---

## Current Status

Sky Lighting System V1 is complete.

Implemented:

- SkySystem scene
- SkyCycleController script
- SkyGradient shader
- Full-screen gradient
- Horizon glow
- Day/night cycle
- Player ambient tinting
- CanvasLayer-based zoom isolation

---

## Known Notes

The current gradient shader is good enough for prototype use.

Future polish may include:

- Reduced banding
- Subtle dithering
- Noise-based atmospheric texture
- Better night tuning
- Better sunset tuning
- Cloud color modulation
- Island tinting
- Projectile contrast validation
- Soul core contrast compensation

---

## Future Expansion

This system may later support:

- Sun layer
- Moon layer
- Stars
- Nebulae
- Weather tinting
- Atmospheric fog
- Cloud color modulation
- Time-based music transitions
- Enemy behavior changes based on time of day
- Death-sequence scene dimming
- Sanctuary return fade/wake lighting
- Gameplay readability presets per time of day

Stars and nebulae are intentionally postponed.

Current priority after this system is:

- Parallax cloud layers
- Parallax floating island layers
- Sky depth illusion
- Gameplay systems

---

## Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should preserve lighting readability.

In scope:

- Sky Lighting System v1
- Atmospheric rendering foundation
- Player ambient tinting
- Lighting integration review with Sky Layer Manager
- Soul core readability validation over major lighting phases
- Enemy projectile readability consideration before enemy bullets are implemented

Deferrable:

- Final production lighting polish
- Full death lighting sequence
- Full sanctuary wake lighting
- Weather tinting
- Cloud-specific tinting
- Full star/nebula system

---

## QA / Validation Checklist

Validate:

- Soul core remains readable in morning.
- Soul core remains readable in day.
- Soul core remains readable in sunset.
- Soul core remains readable at night.
- Enemy projectiles remain readable against major lighting phases.
- Player bullets do not overpower the core.
- Horizon glow does not hide projectiles.
- Player ambient tint does not obscure the true hitbox.
- Death-scene dimming direction preserves core rupture visibility.
- UI remains readable over lighting/dimming when appropriate.

---

## Open Questions

- Should the soul core ignore player ambient tint, partially inherit it, or compensate against it?
- Should enemy projectiles receive contrast compensation based on current sky phase?
- Should death-scene dimming be handled by Sky Lighting System, UI System, a death VFX controller, or a future scene transition controller?
- Should sky time-of-day affect enemy behavior in Pre-Alpha 0.1 or later?
- Should stars/nebulae be clamped so they never mimic soul-core sparkle?

---

# Final Rule

Lighting should make the world feel alive.

Lighting should not hide the game.

The soul core and enemy projectiles must remain readable in every lighting phase.
