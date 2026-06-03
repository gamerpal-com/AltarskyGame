# Sky Time Map

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if sky-time responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when sky-time tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if sky time, lighting phases, day/night behavior, or time-based readability affects Pre-Alpha 0.1 scope.
> - `docs/planning/roadmap.md` — update when sky-time planning changes active or future roadmap direction.
> - `docs/systems/sky_lighting_system.md` — update when lighting phases, phase duration, time-of-day transitions, death dimming, or player ambient tinting changes.
> - `docs/systems/skyflow_director.md` — update when time-of-day affects sky layers, biome behavior, environmental spawning, or sky orchestration.
> - `docs/systems/sky_depth_system.md` — update when time-of-day affects depth readability, cosmetic layer filtering, or gameplay/background separation.
> - `docs/systems/player_soul_core.md` — update when time-of-day lighting affects soul core visibility, glow, dimming, damage feedback, or death VFX.
> - `docs/systems/projectile_system.md` — update when time-of-day affects projectile readability, enemy bullet contrast, or combat visibility.
>
> Do not update this document in isolation when sky time changes affect lighting, sky layers, player readability, projectile readability, release scope, or roadmap direction.

---

# Purpose

This document tracks sky time-of-day planning for AltarSky.

It connects:

- Time-of-day phases
- Sky lighting
- Sky layer presentation
- Future biome/time rules
- Soul core readability
- Projectile readability
- Day/night crystal and drop rules

This is a planning document, not the current runtime implementation.

Current runtime lighting implementation is documented in:

- `docs/systems/sky_lighting_system.md`

---

# Current Runtime Lighting Phases

The current Sky Lighting System supports four phases:

- Morning
- Day
- Sunset
- Night

These are currently used for atmospheric sky color transitions and player ambient tinting.

Current test values may be short for rapid iteration.

Future production values should be tuned later.

---

# Readability Rule

Time-of-day lighting must never hide gameplay.

Every sky phase must preserve readability of:

- Player soul core
- Enemy projectiles
- Player position
- Bullet paths
- UI when relevant
- Death sequence visuals

The soul core should remain readable in:

- Morning
- Day
- Sunset
- Night
- Death-scene dimming
- Future biome/weather lighting

Enemy projectiles should remain readable against every major sky phase.

See:

- `docs/systems/player_soul_core.md`
- `docs/systems/projectile_system.md`
- `docs/systems/sky_depth_system.md`
- `docs/systems/sky_lighting_system.md`

---

# Planned Time-of-Day Direction

Future time-of-day may affect:

- Sky color
- Cloud tint
- Island tint
- Background visibility
- Star visibility
- Enemy behavior
- Biome mood
- Crystal drops
- Music/ambience
- Death/revival mood
- Sanctuary transition lighting

These should be added gradually and only after the core sky/gameplay readability is stable.

---

# Crystal / Biome Time Rule

Current design direction:

- Daytime drops one crystal type.
- Nighttime drops the opposite crystal type.
- Dusk and dawn can drop both types.
- Dusk/dawn weighting should bias toward one type or the other depending on phase.
- The dusk/dawn bias should be inverse between the two transition phases.

This rule is planned and not yet final implementation.

Related future systems:

- Biome system
- Magic type system
- Upgrade system
- Drop/reward system
- Run progression system

---

# Future Phase Model

Possible future expanded phase model:

- Dawn
- Morning
- Day
- Dusk
- Night

Current implementation only needs:

- Morning
- Day
- Sunset
- Night

The future model should not be implemented until needed.

---

# Soul Core / Death Lighting Relationship

The soul core death sequence may use lighting and dimming.

Intended direction:

- Fatal hit cracks the soul core.
- Scene slows/freezes.
- Scene dims.
- Soul core destabilizes.
- Rays of light rupture out.
- Astral projection vaporizes.
- Magical explosion occurs.
- Fade out.
- Sanctuary/home fade-in occurs.

Sky time and lighting systems may eventually help control scene dimming, fade, and mood.

However, dimming must not hide the soul core rupture.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`
- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should only require simple sky-time behavior.

In scope:

- Existing lighting phases.
- Basic sky color transitions.
- Player ambient tinting.
- Soul core readability review across major phases.
- Projectile readability consideration before enemy bullets are added.

Deferrable:

- Full dawn/dusk model.
- Crystal/time drop rules.
- Biome-time interaction.
- Enemy time-of-day behavior.
- Music transitions.
- Full death lighting integration.
- Sanctuary fade lighting.

---

# Open Questions

- Should the future system rename Sunset to Dusk?
- Should Dawn become a distinct phase before or after biome work?
- Which crystal type belongs to day vs night?
- How long should each production time phase last?
- Should time-of-day progress during active runs only, or also at home/sanctuary?
- Should time-of-day affect enemy behavior before or after Pre-Alpha 0.1?
- Should soul core glow compensate automatically against current sky phase?

---

# Final Rule

Sky time exists to support atmosphere, progression, and world identity.

It must not reduce gameplay readability.

Every time-of-day phase must preserve the soul core and enemy projectile readability relationship.
