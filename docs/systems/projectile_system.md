# Projectile System

## Purpose

The Projectile System documents how bullets currently work in the ALTARSKY prototype and defines the future direction for a proper shared projectile framework.

At the moment, player shooting exists as a basic prototype system. It is functional, but not yet separated into a full bullet-hell projectile architecture.

---

## Current Primary Files

```text
scripts/gameplay/Player.gd
scripts/gameplay/bullet.gd
scenes/Bullet.tscn
assets/Projectiles/Player Bullet.png
Current Implementation

Player bullet spawning is currently handled inside:

scripts/gameplay/Player.gd

The player controller owns:

Fire input state
Fire cooldown
Shots-per-second limiting
Bullet scene instancing
Bullet speed assignment
Bullet lifetime assignment
Bullet scale assignment

The bullet itself is handled by:

scripts/gameplay/bullet.gd

The bullet script currently controls:

Movement
Lifetime expiration
Self-removal after lifetime ends
Current Player Bullet Flow
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
Current Limitations

The current setup is acceptable for prototype testing, but it is not the final projectile architecture.

Current limitations:

Player.gd directly spawns bullets
No shared projectile manager
No enemy bullet support yet
No projectile ownership/team system yet
No damage payload system yet
No pattern emitter system yet
No object pooling yet
No bullet collision architecture documented yet
No support for boss bullet patterns yet
Refactor Goal

The current player bullet logic should eventually be separated into a dedicated projectile system.

Future structure may become:

ProjectileSystem
├── PlayerProjectile
├── EnemyProjectile
├── BossProjectile
├── ProjectileEmitter
├── PatternController
└── ProjectilePool

The player should eventually request shots from the projectile system instead of directly owning all bullet spawning logic.

Future Responsibilities

A complete Projectile System should eventually handle:

Player bullets
Enemy bullets
Boss bullets
Bullet ownership
Bullet collision layers
Bullet damage values
Bullet speed
Bullet lifetime
Bullet scaling
Bullet visual style
Bullet patterns
Spread shots
Spiral patterns
Waves
Aimed shots
Object pooling
Performance optimization
Bullet Ownership

Future projectiles should identify their source.

Possible ownership values:

Player
Enemy
Boss
Neutral
Environmental

This will help determine:

What the projectile can damage
What collision layers it uses
Whether it contributes to scoring
Whether it can be canceled, reflected, or absorbed
Pattern System Direction

Because ALTARSKY is a vertical bullet-hell RPG, projectiles will eventually need pattern support.

Future pattern types may include:

Straight shot
Spread shot
Fan pattern
Spiral pattern
Ring burst
Aimed shot
Delayed burst
Rotating emitter
Boss phase pattern

This should not be built until the basic projectile separation is complete.

Performance Notes

Bullet-heavy gameplay will eventually require object pooling.

The current instantiate/delete approach is fine for early prototype work, but may become expensive once enemy and boss bullet patterns are added.

Future optimization target:

Spawn from pool
Move/update
Disable when expired
Return to pool
Reuse later
Current Status

Prototype player bullet system exists and works.

A full shared projectile architecture has not been implemented yet.

Next Step

Before adding enemy bullets or boss patterns, assess whether to refactor the current Player.gd bullet spawning into a dedicated projectile system.

Recommended next milestone:

Projectile System V1
├── Move bullet spawning out of Player.gd
├── Add projectile ownership
├── Support player bullets
├── Prepare for enemy bullets
└── Keep behavior identical to current prototype
