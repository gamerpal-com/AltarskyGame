# Projectile System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if projectile-system responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if projectile work changes Developer Hat, QA Hat, Art Director Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when projectile tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if projectile behavior, enemy bullets, player bullets, collision, or bullet-hell readiness affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/gameplay.md` — update when projectile behavior affects combat flow, damage flow, scoring, player survival, or gameplay loop.
> - `docs/systems/player_controller.md` — update when player bullet spawning, fire input, or weapon ownership changes.
> - `docs/systems/player_soul_core.md` — update when projectile/core collision, enemy bullet readability, true hitbox behavior, or bullet visual hierarchy changes.
> - `docs/systems/ui_system.md` — update when projectile behavior affects HUD, debug UI, score UI, or death/result UI.
>
> Do not update this document in isolation when projectile behavior changes affect player control, soul core collision, gameplay flow, UI, or release scope.

---

## Purpose

The Projectile System documents how bullets currently work in the AltarSky prototype and defines the future direction for a proper shared projectile framework.

At the moment, player shooting exists as a basic prototype system.

It is functional, but not yet separated into a full bullet-hell projectile architecture.

---

## Current Primary Files

```text
scripts/gameplay/Player.gd
scripts/gameplay/bullet.gd
scenes/Bullet.tscn
assets/Projectiles/Player Bullet.png
```

---

## Current Implementation

Player bullet spawning is currently handled inside:

```text
scripts/gameplay/Player.gd
```

The player controller owns:

- Fire input state
- Fire cooldown
- Shots-per-second limiting
- Bullet scene instancing
- Bullet speed assignment
- Bullet lifetime assignment
- Bullet scale assignment

The bullet itself is handled by:

```text
scripts/gameplay/bullet.gd
```

The bullet script currently controls:

- Movement
- Lifetime expiration
- Self-removal after lifetime ends

---

## Current Player Bullet Flow

```text
Player moves or drags
↓
is_shooting becomes true
↓
fire cooldown counts down
↓
Player.gd instantiates Bullet.tscn
↓
Bullet receives velocity and lifetime
↓
Bullet moves upward
↓
Bullet deletes itself when lifetime expires
```

---

## Current Limitations

The current setup is acceptable for prototype testing, but it is not the final projectile architecture.

Current limitations:

- Player.gd directly spawns bullets.
- No shared projectile manager.
- No enemy bullet support yet.
- No projectile ownership/team system yet.
- No damage payload system yet.
- No pattern emitter system yet.
- No object pooling yet.
- No bullet collision architecture documented yet.
- No support for boss bullet patterns yet.
- No soul-core collision tuning yet.

---

## Soul Core / Projectile Readability Rule

Enemy projectiles and the player soul core form the primary bullet-hell readability relationship.

The player should always understand:

- Soul core = where I am.
- Enemy projectiles = what can kill me.

Enemy projectiles should be tuned against the soul core, not against the full player body.

Enemy projectile behavior should eventually account for:

- Soul core true hitbox radius.
- Projectile collision shape.
- Projectile speed.
- Projectile visual size.
- Projectile threat readability.
- Projectile render priority.
- Mobile screen readability.
- Sky/environment background filtering.

Enemy projectiles must not be hidden by cosmetic sky/environment layers.

Enemy projectiles must not visually imitate the soul core's rapid RGB center sparkle.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/gameplay.md`

---

## Player Bullet Relationship

Player bullets should provide satisfying feedback without overpowering the soul core or enemy projectile threats.

Player bullets should avoid:

- Looking like enemy bullets.
- Matching the soul core sparkle language.
- Overpowering the soul core.
- Filling the screen with unreadable effects.
- Confusing the player about what is dangerous.

Survival readability has priority over player bullet spectacle.

---

## Refactor Goal

The current player bullet logic should eventually be separated into a dedicated projectile system.

Future structure may become:

```text
ProjectileSystem
├── PlayerProjectile
├── EnemyProjectile
├── BossProjectile
├── ProjectileEmitter
├── PatternController
└── ProjectilePool
```

The player should eventually request shots from the projectile system instead of directly owning all bullet spawning logic.

---

## Future Responsibilities

A complete Projectile System should eventually handle:

- Player bullets
- Enemy bullets
- Boss bullets
- Bullet ownership
- Bullet collision layers
- Bullet damage values
- Bullet speed
- Bullet lifetime
- Bullet scaling
- Bullet visual style
- Bullet patterns
- Spread shots
- Spiral patterns
- Waves
- Aimed shots
- Object pooling
- Performance optimization
- Soul core collision testing
- Enemy projectile readability against sky layers

---

## Bullet Ownership

Future projectiles should identify their source.

Possible ownership values:

- Player
- Enemy
- Boss
- Neutral
- Environmental

This will help determine:

- What the projectile can damage.
- What collision layers it uses.
- Whether it contributes to scoring.
- Whether it can be canceled, reflected, or absorbed.
- Whether it should interact with the soul core.

---

## Pattern System Direction

Because AltarSky is a vertical bullet-hell RPG, projectiles will eventually need pattern support.

Future pattern types may include:

- Straight shot
- Spread shot
- Fan pattern
- Spiral pattern
- Ring burst
- Aimed shot
- Delayed burst
- Rotating emitter
- Boss phase pattern

This should not be built until the basic projectile separation is complete.

---

## Performance Notes

Bullet-heavy gameplay will eventually require object pooling.

The current instantiate/delete approach is fine for early prototype work, but may become expensive once enemy and boss bullet patterns are added.

Future optimization target:

```text
Spawn from pool
Move/update
Disable when expired
Return to pool
Reuse later
```

---

## Current Status

Prototype player bullet system exists and works.

A full shared projectile architecture has not been implemented yet.

Enemy bullets are not implemented yet.

Soul-core collision/readability behavior is documented but not fully implemented.

---

## Next Step

Before adding enemy bullets or boss patterns, assess whether to refactor the current Player.gd bullet spawning into a dedicated projectile system.

Recommended next milestone:

```text
Projectile System V1
├── Move bullet spawning out of Player.gd
├── Add projectile ownership
├── Support player bullets
├── Prepare for enemy bullets
├── Review soul-core collision/readability
└── Keep behavior identical to current prototype
```
