# Player Soul Core System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/00_start_here.md` — review if player-core workflow, project onboarding, hat routing, or source-of-truth routing changes.
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — review if this document creates new documentation rules, folder expectations, maintenance-note requirements, or no-orphan-doc implications.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if this document is added, renamed, removed, re-scoped, or becomes a major source of truth for player identity, gameplay readability, death flow, or rendering hierarchy.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if this system changes Developer Hat, Art Director Hat, QA Hat, Documentation Architect Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when implementation tasks, completed work, blockers, deferred documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if player soul core behavior becomes part of Pre-Alpha 0.1 release criteria or affects release readiness.
> - `docs/game_flow/gameplay.md` — update when soul core gameplay behavior, hitbox behavior, combat readability, damage response, or death flow changes.
> - `docs/game_flow/home.md` — update when sanctuary return, post-death wake-up, recovery, or preparation flow changes.
> - `docs/game_flow/game_state_map.md` — update when death, revival, sanctuary return, gameplay state transitions, or soft-break flow changes.
> - `docs/systems/player_controller.md` — update when player movement, hitbox, damage handling, core positioning, or player scene ownership changes.
> - `docs/systems/projectile_system.md` — update when enemy projectile readability, collision priority, layer relationship, or bullet/core interaction changes.
> - `docs/systems/skyflow_director.md` — update when sky/environment readability rules affect player visibility, combat corridor, or background filtering.
> - `docs/systems/sky_depth_system.md` — update when depth filtering, layer separation, player readability, or cosmetic layer quality boundaries change.
> - `docs/systems/sky_lighting_system.md` — update when lighting, glow, dimming, death VFX, or core visibility rules change.
> - `docs/systems/ui_system.md` — update when UI/camera UI layers interact with player core visibility or post-death result popups.
> - `docs/planning/roadmap.md` — update if soul core behavior changes MVP/Pre-Alpha priorities or future gameplay direction.
> - `docs/planning/sky_time_map.md` — update if time-of-day lighting affects soul core readability, glow, dimming, or visual hierarchy.
>
> Do not update this document in isolation when changes affect gameplay readability, render hierarchy, player control, projectile behavior, death flow, sanctuary flow, or release scope.

---

# Purpose

This document defines the Player Soul Core system.

The soul core is the real player from a gameplay/readability perspective.

The visible player body, wings, clothing, and animation are the projected physical form around the soul core.

The soul core is the true hitbox, the primary readable gameplay anchor, and the highest-priority gameplay visual.

This document explains:

- What the soul core is.
- Why it exists.
- How it fits AltarSky lore.
- How it defines hitbox/readability.
- How it interacts with the player body.
- How it fits the render/layer hierarchy.
- How it interacts with projectiles.
- How damage and death should work.
- How sanctuary return and revival fit the system.
- What belongs in Pre-Alpha 0.1.
- What should be deferred.

---

# Core Rule

The player is the only entity with a center soul core.

Nothing else should share the same center-core visual identity.

The soul core is absolute gameplay layer 0.

Only UI and scene/camera UI may be above it.

Enemy projectiles sit directly below the soul core as the next most important gameplay-readable objects.

The core and enemy projectiles together define the core readable gameplay language:

- Where I am.
- What can kill me.

---

# Lore Foundation

The player character is not physically alive in the normal sense.

The player is an astral projection of the dead.

The visible body is a magical manifestation around the soul.

The body is not the true vulnerable physical object.

The soul core is the actual player.

This explains why bullets can pass through the player body, wings, clothing, or projected form, while only the soul core is the real hitbox.

The player body is a magical physical-form projection.

The soul core is the real survivable entity.

Damage should feel like the projection is destabilizing.

Death should feel like the soul projection ruptures.

Revival can be explained as the soul core re-stabilizing or re-manifesting after rupture.

---

# Gameplay Purpose

The soul core exists to solve multiple gameplay and identity problems at once.

It provides:

- A true hitbox marker.
- A clear player tracking point.
- Bullet-hell readability.
- A visual identity anchor.
- A lore explanation for why the body is not the hitbox.
- A system hook for health, charge, damage, death, and revival.
- A way to separate gameplay clarity from cosmetic player art.
- A way to keep the player readable over complex sky layers and effects.

The player sprite/body may become visually rich over time.

The soul core must remain simple, readable, and dominant.

---

# Player Body vs Soul Core

The player body is the visual projection.

The soul core is the real player.

## Player Body

The body includes:

- Character sprite
- Wings
- Clothing
- Hair
- Animation shell
- Cosmetic VFX attached to body
- Projected physical form

The body is mostly an art piece and animation shell.

It may dim, fade, flicker, distort, or destabilize when damaged.

It should not be used as the real collision target for enemy bullets.

## Soul Core

The soul core includes:

- True hitbox
- Center gameplay marker
- Player-readable anchor
- Damage/health signal source
- Charge/energy signal source
- Death rupture origin
- Revival/restabilization origin

The soul core should be controlled separately from the player body.

It should not be permanently baked into the default player sprite once the system is implemented.

---

# Implementation Direction

The soul core should be separated from the default player sprite.

Reason:

- Sky Layer Manager layers are becoming visually complex.
- Enemy sprites and enemy projectiles are upcoming.
- The core needs independent render priority.
- The core needs independent health/damage/charge/death behavior.
- The core needs independent dimming and sparkle tuning.
- The core needs to remain readable even when the body is hidden or disabled.
- The core should support combat testing without needing the full body or sky layers enabled.

Implementation direction:

1. Update the in-game player sprite first.
2. Add the soul core as its own renderable element.
3. Position it over the correct center point of the player body.
4. Render it above the player body and all gameplay effects except UI.
5. Use the soul core as the true hitbox marker.
6. Allow the player body to be disabled while keeping the core visible.
7. Allow sky/environment layers to be disabled while testing core combat.
8. Re-enable body/environment after combat readability is tuned.

---

# Debug / Development Workflow

The soul core enables a useful development workflow.

For combat testing:

- Disable sky layer visuals if needed.
- Disable player body if needed.
- Leave only the soul core visible.
- Tune player movement.
- Tune enemy bullet readability.
- Tune collision/hitbox behavior.
- Add enemy sprites and player body back after core combat is readable.
- Add sky layers back after combat readability is stable.

This allows the game to be developed around the true gameplay object first.

The body, wings, sky, clouds, islands, and VFX should enhance the experience without hiding the core gameplay language.

---

# Visual Hierarchy

The soul core is the highest-priority gameplay visual.

Current intended hierarchy:

- Layer 2: Scene camera UI
- Layer 1: UI
- Layer 0: Player soul core / true hitbox marker
- Layer 0.5: Select specialized VFX / special-case visuals
- Layer -1: Enemy projectiles
- Layer -2: Player body and wings
- Layer -3: Player bullets
- Layer -4: Enemy sprites
- Layers below -4: cosmetic environment/background
- Approximately Layer -10 through Layer -30: parallax sky/environment reserved layers

Important rule:

Even if a specialized VFX layer is represented as 0.5, it must not overpower or obscure the soul core.

The soul core remains the top gameplay readability anchor.

Only UI may truly dominate it.

---

# Gameplay Layer Rules

## Layer 2 — Scene Camera UI

Scene/camera interface elements may sit above everything.

Use for camera/editor/debug UI as needed.

## Layer 1 — UI

Normal UI sits above gameplay visuals.

Examples:

- HUD
- Menus
- Post-death consequence popup
- Debug UI when active

UI may cover the soul core when the game is in menu, transition, pause, post-death, or overlay states.

During active gameplay, UI should not unnecessarily obscure core readability.

## Layer 0 — Player Soul Core

The soul core is absolute gameplay layer 0.

It rides above:

- Player body
- Player wings
- Player bullets
- Enemy sprites
- Enemy projectiles
- Environmental effects
- Lighting effects
- Sky layers
- Clouds
- Islands
- Background VFX

Nothing should visually overpower it except UI.

## Layer 0.5 — Select Specialized VFX

This is reserved for rare special-case visuals.

These effects may be visually important, but they must not destroy soul-core readability.

If a special VFX competes with the core, it should be:

- Dimmed
- Masked
- Rendered behind core
- Given lower intensity
- Temporarily suppressed near the core
- Tuned for readability

## Layer -1 — Enemy Projectiles

Enemy projectiles are the next-highest gameplay readability priority after the soul core.

Enemy projectiles are co-primary gameplay objects with the core.

They communicate danger.

They should remain visually dominant as threats without destroying soul-core tracking.

Enemy projectiles should never become hidden behind cosmetic sky/environment layers.

## Layer -2 — Player Body and Wings

The player body is below the core.

The body is visual identity and animation, not the true hitbox.

The body can be beautiful, animated, and expressive, but must not confuse the player about the true hitbox.

## Layer -3 — Player Bullets

Player bullets sit below the body/core priority stack.

They must be readable enough for feedback but should not overpower enemy bullets or the soul core.

## Layer -4 — Enemy Sprites

Enemy sprites are below player bullets and enemy projectiles.

Enemy sprites must remain readable but should not visually compete with the core or enemy bullets.

## Below Layer -4 — Cosmetic / Atmosphere

Everything below layer -4 is cosmetic or atmospheric.

This includes:

- Sky layers
- Clouds
- Islands
- Fog
- Background stars
- Environmental particles
- Atmospheric lighting
- Parallax layers

These layers should support the world without competing with gameplay readability.

---

# Cosmetic Layer Filter Boundary

Layers 1 through -4 are the literal gameplay stack.

Layers below -4 are cosmetic/atmosphere.

There should be a hard, tunable visual filter boundary below layer -4.

Purpose:

- Keep cosmetic layers slightly lower priority.
- Preserve gameplay clarity.
- Prevent background assets from competing with the soul core and projectiles.
- Let sky/world remain beautiful without hurting bullet-hell readability.

The quality/clarity decrease should be subtle.

It should not make the background ugly.

It should be tunable through inspector/configuration values.

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

The boundary should be adjustable.

---

# Soul Core Visual Identity

The soul core should be visually unique.

It should be the only center core of its kind.

Direction:

- Center orb / soul marker
- Rapid RGB star-like sparkle
- High readability
- Above every gameplay effect
- Strong visual priority
- Clean silhouette
- Clear center point

The rapid RGB sparkle belongs to the soul core.

Other things may glow, sparkle, or twinkle, but they should not imitate the soul core.

Background stars may twinkle, but slower and lower intensity.

No enemy, pet, item, background star, UI ornament, or environmental asset should share the exact same rapid center-core sparkle identity.

---

# Soul Core Hitbox Rule

The soul core is the true hitbox.

Enemy bullets should collide with the soul core, not the full body.

The player body and wings should not be treated as the main bullet collision target.

Collision should be tuned around:

- Core size
- Core visibility
- Enemy projectile size
- Bullet speed
- Player movement
- Touch/mouse control feel
- Mobile screen readability

The body can visually react to damage, but gameplay collision is core-first.

---

# Enemy Projectile Relationship

Enemy projectiles and the soul core form the primary bullet-hell readability relationship.

The player should always understand:

- Where the true hitbox is.
- Which enemy bullets are dangerous.
- Whether a bullet will hit the core.

Enemy projectile visuals should be tuned against the soul core, not against the full body.

Enemy projectile design should avoid:

- Matching the core too closely.
- Using identical rapid RGB center sparkle.
- Hiding behind sky/environment layers.
- Becoming less readable than player bullets.
- Being overpowered by player body effects.
- Being confused with harmless VFX.

Enemy projectiles may appear visually dominant because they represent danger, but they must not erase core tracking.

---

# Player Bullet Relationship

Player bullets sit below the player body/core priority and below enemy projectile priority.

Player bullets should provide satisfying feedback without competing with the core/enemy projectile readability pair.

Player bullets should avoid:

- Overpowering the soul core.
- Looking like enemy bullets.
- Matching the core sparkle language.
- Filling the screen with unreadable effects.

Player bullet readability matters, but survival readability matters more.

---

# Sky / Environment Relationship

The sky world should feel alive and layered.

But the environment must never win against gameplay readability.

Sky layers should support:

- Atmospheric depth
- Sense of motion
- World identity
- Distant scale
- Islands below/around the player
- Cloud drift and weather feel
- Forward flight fantasy

Sky layers should not:

- Hide the soul core.
- Hide enemy projectiles.
- Confuse the player body with the hitbox.
- Create high-frequency sparkle competing with the core.
- Overpower the gameplay stack.
- Make the player corridor unreadable.

The Sky Layer Manager and Skyflow Director should respect the player soul core as the highest-priority gameplay object.

---

# Damage Direction

When the soul core takes damage, the projected body should react.

Possible damage feedback:

- Body fades out/in briefly.
- Body flickers.
- Core flashes.
- Core dims then stabilizes.
- Projection shimmers.
- Wings/body destabilize.
- Localized crack/energy reaction.
- Brief loss of projection intensity.
- Short invulnerability-style pulse if needed.

Damage should communicate:

- The soul core was struck.
- The projection destabilized.
- The player survived and restabilized.

The body reaction should not make the true core unreadable.

If body fade/flicker happens, the core should remain trackable.

---

# Weak / Injured State Direction

When the player is weak or injured, the projection can become less stable.

Possible weak-state signals:

- Body dimming
- Lower projection opacity
- Slower body glow
- Reduced wing intensity
- Core less stable but still readable
- Slight flicker
- Subtle color shift
- Reduced aura
- Short destabilization pulses

Important:

The weak state should not hide the soul core.

The soul core must remain readable even when weakened.

---

# Death Sequence Direction

Player death is not a normal physical death.

Death is the soul core fracturing and the astral projection rupturing.

It should feel grand, devastating, and rare.

Dying in AltarSky is a major event, not a quick arcade reset.

Fatal blow sequence direction:

1. Fatal hit connects with the soul core.
2. Sharp glass-break / cracking sound plays immediately.
3. Deep generator-like power-down sound begins: "bmmmmmmmmmm".
4. Gameplay time freezes or slows dramatically.
5. Scene dims.
6. Soul core destabilizes.
7. Rays of light poke out from the core/projection one after another.
8. The astral body vaporizes or collapses.
9. A massive magical explosion releases outward.
10. The scene fades out softly.
11. The player fades back in as if waking up at their sanctuary.
12. A sanctuary results/loss popup appears.
13. The popup displays score, what was lost, rank damage, run consequences, and other relevant post-run information.
14. The player is released into the sanctuary to prepare for the next run.

The glass break communicates:

- The soul core cracked.

The generator shutdown communicates:

- The magic sustaining the projection is failing.

The explosion communicates:

- The soul projection ruptured.

The fade/wake sequence communicates:

- The projection was destroyed, but the soul has returned to sanctuary.

The death effect should feel magical, catastrophic, and lore-consistent.

It should not feel like a normal body death.

It should also not route directly into a normal replay menu.

AltarSky should preserve a fluid soft-break structure:

- The player returns to sanctuary first.
- Then receives the consequence summary there.

---

# Sanctuary Return After Death

Death returns the player to sanctuary through a soft cinematic transition.

The player should not be dropped into a hard game-over screen or normal replay menu.

Intended flow:

- Projection rupture
- Magical explosion
- Fade out
- Fade in at sanctuary
- Player wakes / reforms / stabilizes
- Consequence popup appears
- Score, losses, rank damage, and run results are shown
- Player closes or confirms the popup
- Player resumes control in sanctuary
- Player prepares for the next run

This keeps AltarSky's flow consistent with the soft-break philosophy.

The sanctuary is the recovery and preparation space.

Death should return the player there because death represents the collapse of the active astral projection, not the end of the player's existence.

The post-death popup belongs in sanctuary, after the fade-in/wake-up moment, not before.

---

# Revival Hook

This lore allows revival mechanics to exist naturally.

Because death is projection rupture instead of ordinary physical death, revival can mean:

- The soul core re-stabilizes.
- The projection re-manifests.
- A sanctuary force pulls the soul back.
- A rare resource prevents full rupture.
- A pet/relic/magic effect helps re-anchor the soul.
- The projection reforms after near-collapse.

Possible revival visual direction:

1. Soul core fractures.
2. Death sequence starts.
3. Revival trigger interrupts total rupture.
4. Core pulls scattered light back inward.
5. Projection reforms.
6. Player re-enters combat or returns to a safe state.

Revival should preserve the rule that the soul core is the true player.

---

# UI / Result Popup Relationship

UI is above the soul core.

Post-death consequence popup belongs in sanctuary after the fade-in/wake-up moment.

The popup should display:

- Score
- What was lost
- Rank damage
- Run consequences
- Items lost
- Temporary upgrades lost
- Rewards preserved, if any
- Next preparation options

The popup should not appear immediately at the moment of death before the sanctuary return.

Death should flow cinematically first.

Results should appear after the player is back at sanctuary.

---

# Audio Direction

Fatal blow audio sequence:

1. Sharp glass-break / cracking sound.
2. Deep generator-like power-down sound: "bmmmmmmmmmm".
3. Magical destabilization sounds.
4. Light-ray rupture sounds.
5. Massive magical explosion.
6. Fade-out / transition ambience.
7. Sanctuary wake-up/reform sound.

The glass break should be immediate.

The generator shutdown should feel like power leaving the projection.

The explosion should feel magical and soul-based, not physical gore or body destruction.

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 should not require the full final soul core system.

However, the architecture should start moving in the correct direction.

Recommended Pre-Alpha 0.1 scope:

- Separate soul core from baked player sprite if practical.
- Ensure core renders above player body.
- Ensure core remains readable over sky layers.
- Use core as the true hitbox marker.
- Begin tuning enemy projectile readability around the core.
- Preserve layer hierarchy rules.
- Document death/sanctuary direction even if not fully implemented.
- Allow body/core separation for future damage/death/charge behavior.

Possible Pre-Alpha 0.1 deferrals:

- Full death cinematic.
- Full sanctuary wake-up sequence.
- Full revival system.
- Full weak-state projection effects.
- Full charge-up core behavior.
- Advanced core shaders.
- Complex damage-state animations.
- Full scene map documentation.

---

# Implementation Notes

Potential implementation structure:

- Player scene owns player body and soul core.
- Soul core is a separate child node or renderable element.
- Soul core has independent render priority.
- Soul core position is aligned to intended hitbox center.
- Collision shape should match the soul core.
- Body sprite should sit below the core.
- Damage/death VFX should reference core position.
- Enemy projectile collision should target the core collision area.
- Debug/testing should allow body visibility toggles and core-only testing.

Possible node concepts:

- PlayerRoot
- PlayerBody
- PlayerWings
- PlayerSoulCore
- PlayerHitbox
- PlayerDamageVFX
- PlayerDeathVFX

Exact Godot node structure should be documented later in future scene map docs if needed.

---

# Inspector / Tuning Needs

Future tuning controls may include:

- Core visibility enabled/disabled
- Core sparkle intensity
- Core glow intensity
- Core RGB shift speed
- Core hitbox radius
- Core render priority
- Core damage flash duration
- Core weak-state dim amount
- Core death dim timing
- Body fade duration on hit
- Body weak-state opacity
- Death slow-motion scale
- Death scene dim amount
- Death light-ray timing
- Death explosion scale
- Death transition delay

These should be inspector-driven where practical.

---

# QA / Validation Checklist

Validate:

- Soul core remains visible over sky layers.
- Soul core remains visible over player body.
- Soul core remains visible during normal gameplay.
- Soul core is not confused with background stars.
- Soul core is not confused with enemy projectiles.
- Enemy projectiles remain readable.
- Enemy projectiles are not hidden by cosmetic layers.
- Player bullets do not overpower the core.
- Player body does not confuse the true hitbox.
- Cosmetic layers below -4 do not overpower gameplay stack.
- Damage feedback does not hide the core.
- Weak-state visuals do not hide the core.
- Death sequence direction routes to sanctuary, not direct game-over menu.
- UI can appear above the core when appropriate.
- Mobile screen readability is preserved.

---

# Related Systems

This system affects:

- Player Controller
- Projectile System
- Skyflow Director
- Sky Depth System
- Sky Lighting System
- UI System
- Game Flow
- Home / Sanctuary Flow
- Release Tracker
- Roadmap
- Future Scene Maps

Do not treat the soul core as an isolated art detail.

It is a gameplay, lore, rendering, and flow system.

---

# Open Questions

Open questions:

- What exact Godot node structure should own the soul core?
- Should the soul core be a Sprite2D, AnimatedSprite2D, shader-driven effect, VFX node, or custom scene?
- What is the exact core hitbox radius for Pre-Alpha 0.1?
- Should enemy projectiles ever visually overlap the core, or should the core always punch through visually?
- How should specialized Layer 0.5 VFX be sorted relative to the core in Godot if they are allowed to exist?
- What exact opacity/dimming values should the body use when damaged?
- How much of the death sequence belongs in Pre-Alpha 0.1?
- Should revival be planned now or only documented as a future hook?
- Should core-only combat testing become a formal debug mode?
- Should `docs/scene_maps/player_scene.md` be created once the player scene is updated?

---

# Final Rule

The soul core is the player.

The body is the projection.

The core is the true hitbox.

The core is the primary gameplay anchor.

Enemy projectiles are the primary threat language.

Everything else must support that readability.

Do not let visual richness overpower the core.

Do not let the sky hide the game.

Do not let the body confuse the hitbox.

Do not let death feel like a normal reset.

The soul core defines how AltarSky communicates survival.
