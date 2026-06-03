# Sky Depth System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if sky-depth responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if depth/readability work changes Developer Hat, QA Hat, Art Director Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when sky-depth tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if sky depth, gameplay readability, or layer hierarchy affects Pre-Alpha 0.1 release scope.
> - `docs/systems/skyflow_director.md` — update when layer behavior, environmental streaming, player corridor, or depth rules change.
> - `docs/systems/sky_lighting_system.md` — update when lighting, time-of-day tinting, dimming, glow, or atmospheric color affects depth/readability.
> - `docs/systems/player_soul_core.md` — update when render hierarchy, gameplay layer priority, cosmetic filter boundary, or soul-core readability changes.
> - `docs/systems/projectile_system.md` — update when enemy projectile visibility, bullet/background separation, or projectile layer priority changes.
> - `docs/game_flow/gameplay.md` — update when depth/readability affects active gameplay flow or combat clarity.
>
> Do not update this document in isolation when depth rules affect sky/environment behavior, soul core readability, projectile readability, lighting, gameplay flow, or release scope.

---

# Purpose

The Sky Depth System defines how AltarSky separates gameplay visuals from cosmetic/atmospheric visuals.

It explains:

- Render/readability hierarchy
- Gameplay layer priority
- Cosmetic layer boundary
- Depth filtering rules
- Sky/environment depth behavior
- Soul core and projectile visibility expectations

The goal is to let AltarSky have a rich layered sky world without destroying bullet-hell readability.

---

# Core Depth Rule

Gameplay readability has priority over environmental beauty.

The sky world can be beautiful, deep, and atmospheric, but it must not hide:

- The player soul core.
- Enemy projectiles.
- Important gameplay state.
- UI when needed.

The player should always understand:

- Where I am.
- What can kill me.

---

# Gameplay Visual Hierarchy

Current intended hierarchy:

```text
Layer 2: Scene camera UI
Layer 1: UI
Layer 0: Player soul core / true hitbox marker
Layer 0.5: Select specialized VFX / special-case visuals
Layer -1: Enemy projectiles
Layer -2: Player body and wings
Layer -3: Player bullets
Layer -4: Enemy sprites
Layers below -4: cosmetic environment/background
Approximately Layer -10 through Layer -30: parallax sky/environment reserved layers
```

Important:

- The soul core is the top gameplay visual anchor.
- Enemy projectiles are the top threat visual language.
- Cosmetic sky/environment layers should sit below gameplay.
- UI may sit above everything when game state requires it.

See:

- `docs/systems/player_soul_core.md`
- `docs/systems/projectile_system.md`
- `docs/systems/ui_system.md`

---

# Gameplay Stack

Layers 1 through -4 are the literal gameplay stack.

This includes:

- UI
- Soul core
- Enemy projectiles
- Player body
- Player bullets
- Enemy sprites

These layers must remain clear and readable.

The gameplay stack should not be degraded by atmospheric filtering meant for background layers.

---

# Cosmetic / Atmosphere Stack

Layers below -4 are cosmetic or atmospheric unless a future system intentionally promotes them into gameplay.

This includes:

- Sky layers
- Clouds
- Islands
- Fog
- Background stars
- Atmospheric particles
- Environmental lighting
- Parallax backgrounds

These layers support the world fantasy and sense of motion.

They must not compete with the soul core or enemy projectiles.

---

# Cosmetic Layer Filter Boundary

There should be a hard, tunable visual filter boundary below Layer -4.

Purpose:

- Keep cosmetic layers slightly lower priority.
- Preserve gameplay clarity.
- Prevent background assets from competing with the soul core.
- Prevent background assets from hiding enemy projectiles.
- Let the sky remain beautiful without hurting bullet-hell readability.

The quality/clarity decrease should be subtle.

It should not make the sky ugly.

Possible tuning controls:

- Background brightness reduction
- Background contrast reduction
- Background saturation reduction
- Atmospheric haze
- Depth tinting
- Slight blur or softness
- Reduced outline intensity
- Reduced sparkle intensity
- Lighting dampening
- Reduced high-frequency visual detail

The boundary should be adjustable through inspector/configuration values where practical.

---

# Soul Core Readability Rule

The player soul core must remain readable over every sky depth layer.

No depth layer should:

- Match the soul core's rapid RGB center sparkle.
- Hide the soul core.
- Overpower the soul core.
- Create high-frequency flicker around the core.
- Make the player body look like the true hitbox.
- Make the center point ambiguous.

Background stars may twinkle, but they should be slower, dimmer, and less intense than the soul core.

---

# Enemy Projectile Readability Rule

Enemy projectiles must remain readable over every sky depth layer.

No sky/environment layer should:

- Hide enemy projectiles.
- Match enemy projectile colors too closely without contrast.
- Create projectile-like false positives.
- Visually blend into enemy bullet patterns.
- Make bullet paths unreadable.
- Compete with enemy projectile threat language.

Enemy projectile readability should be tested against:

- Day sky
- Night sky
- Sunset sky
- Clouds
- Islands
- Fog / future haze
- Player bullets
- Player body
- Soul core glow

---

# Cloud Depth Direction

Clouds should help communicate atmosphere and motion.

Potential cloud tiers:

- Far clouds
- Mid clouds
- Near clouds
- Large upper/front clouds
- Fog-like pass-through layers

Clouds should vary by:

- Scale
- Opacity
- Drift speed
- Contrast
- Softness
- Layer depth
- Spawn density

Cloud depth should not hide gameplay objects.

Near clouds may create strong atmosphere, but should be tuned carefully around the player corridor.

---

# Island Depth Direction

Islands should help communicate scale and terrain below/around the player.

Potential island tiers:

- Distant megaislands
- Mid-distance islands
- Near edge islands
- Terrain-like side pass islands
- Landmark islands

Islands should feel stable and massive.

Island clarity should decrease with distance.

Distant islands may be partially obscured by clouds.

Near islands should not crowd the player corridor unless intentionally used as hazards in a future design.

---

# Lighting / Depth Relationship

Lighting can reinforce depth through:

- Time-of-day tinting
- Horizon glow
- Atmospheric haze
- Cloud tint
- Island tint
- Background dimming
- Sunset/night contrast

Lighting must not hide gameplay objects.

During death sequence dimming, the soul core and death VFX should remain readable.

See:

- `docs/systems/sky_lighting_system.md`
- `docs/systems/player_soul_core.md`

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should establish the depth/readability direction.

In scope if practical:

- Basic gameplay/cosmetic hierarchy documented.
- Sky layers tuned to avoid hiding player.
- Soul core readability preserved over sky layers.
- Enemy projectile readability considered before enemy bullet implementation.
- Cosmetic filter boundary planned and inspector-tunable where practical.

Deferrable:

- Final depth shader polish
- Full scene map docs
- Full weather/fog system
- Advanced depth-of-field effects
- Final production parallax composition
- Full automated readability tests

---

# QA / Validation Checklist

Validate:

- Soul core is visible over day sky.
- Soul core is visible over night sky.
- Soul core is visible over clouds.
- Soul core is visible over islands.
- Enemy projectiles remain visible over all major sky backgrounds.
- Player bullets do not overpower enemy projectiles.
- Background sparkles do not mimic the soul core.
- Cosmetic layers below -4 feel slightly lower priority than gameplay.
- Depth improves atmosphere without harming bullet dodging.
- Mobile portrait readability is preserved.

---

# Open Questions

- What exact layer values will Godot use for this hierarchy?
- Should cosmetic filtering be per-layer, global, or both?
- Should the filter boundary be implemented in Sky Layer Manager, Skyflow Director, shaders, materials, or canvas modulation?
- Should enemy bullets sit at Layer -1 or a special threat-priority layer closer to the soul core?
- How strong should background filtering be before it harms visual quality?
- Should core-only combat testing be used to tune the depth system?

---

# Final Rule

Depth exists to support gameplay.

The sky can be deep and beautiful.

The soul core and enemy projectiles must remain clearer than the sky.
