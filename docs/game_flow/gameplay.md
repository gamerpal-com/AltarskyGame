# Gameplay Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if gameplay-flow responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if gameplay work changes Developer Hat, QA Hat, Art Director Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when gameplay tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if gameplay flow changes Pre-Alpha 0.1 completion criteria or release readiness.
> - `docs/game_flow/game_state_map.md` — update when gameplay state transitions, death flow, sanctuary return, pause flow, or run/session state changes.
> - `docs/game_flow/home.md` — update when gameplay returns the player to sanctuary/home, especially after death or run completion.
> - `docs/systems/player_soul_core.md` — update when soul core behavior, true hitbox behavior, damage, death, revival, or player readability changes.
> - `docs/systems/player_controller.md` — update when gameplay movement, player control, hitbox ownership, damage handling, or player state changes.
> - `docs/systems/projectile_system.md` — update when shooting, projectile collision, enemy bullet behavior, or core/projectile readability changes.
> - `docs/systems/ui_system.md` — update when gameplay UI, death result popups, score display, pause UI, or HUD flow changes.
>
> Do not update this document in isolation when gameplay flow changes affect player state, death flow, sanctuary return, projectile behavior, UI, or release criteria.

---

# Purpose

This document describes the active gameplay flow for AltarSky.

It explains what happens during a play session, how the player is represented during gameplay, how damage/death should route, and which systems participate in the gameplay loop.

---

# Gameplay Identity

During active gameplay, the player is represented by two related but separate concepts:

- The visible player body / astral projection.
- The player soul core.

The soul core is the real player from a gameplay/readability perspective.

The player body is the projected form around the soul core.

The soul core is the true hitbox.

Enemy bullets should be judged against the soul core, not the full body/wings/clothing.

See:

- `docs/systems/player_soul_core.md`

---

# Core Gameplay Loop

Pre-Alpha 0.1 gameplay should support the first playable sky-world loop:

1. Player starts a play session.
2. Player flies through the atmospheric sky world.
3. Sky/cloud/island layers create depth and motion.
4. Player encounters basic enemies.
5. Player shoots projectiles.
6. Enemy projectiles threaten the soul core.
7. Player destroys enemies.
8. Player earns score.
9. Session ends through return flow, death flow, or future run-completion flow.
10. Player returns to menu/home/sanctuary depending on final flow rules.

---

# Player Readability Rule

Active gameplay must preserve the relationship between:

- Soul core = where I am.
- Enemy projectiles = what can kill me.

The gameplay screen should never make the player lose track of the soul core.

Sky layers, player body, VFX, player bullets, UI, and environmental assets must support gameplay readability.

They must not overpower the soul core or enemy projectile threats.

---

# Damage Flow

When an enemy projectile hits the soul core:

1. Soul core receives damage.
2. Player body/projection may visually destabilize.
3. Damage feedback plays.
4. If player survives, projection stabilizes.
5. If damage is fatal, death sequence begins.

Damage should not be based on the full player body unless a future system intentionally changes this rule.

---

# Death Flow

Death is not a normal body death.

Death is soul core fracture and astral projection rupture.

Fatal gameplay flow:

1. Fatal hit connects with the soul core.
2. Glass-break/cracking sound plays.
3. Generator-like power-down sound begins.
4. Gameplay time freezes or slows dramatically.
5. Scene dims.
6. Soul core destabilizes.
7. Light rays rupture out.
8. Astral projection vaporizes/collapses.
9. Massive magical explosion releases outward.
10. Scene fades out.
11. Player fades back in at sanctuary/home.
12. Player wakes, reforms, or stabilizes.
13. Results/loss popup appears in sanctuary.
14. Player prepares for the next run.

The player should not be routed directly into a hard game-over menu.

See:

- `docs/systems/player_soul_core.md`
- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`

---

# Pre-Alpha 0.1 Gameplay Scope

Pre-Alpha 0.1 should establish the playable gameplay loop.

Required gameplay direction:

- Player movement works.
- Sky world feels atmospheric.
- Basic enemy exists.
- Player can shoot.
- Projectiles exist.
- Score can be earned.
- Soul core design is documented as true hitbox/readability anchor.
- Soul core implementation is reviewed if practical for Pre-Alpha 0.1.
- Death/sanctuary return direction is documented even if not fully implemented.

Deferred if needed:

- Full death cinematic.
- Full sanctuary wake-up sequence.
- Full revival system.
- Advanced core damage states.
- Full run consequence system.

---

# Open Questions

- How much of the soul core implementation belongs in Pre-Alpha 0.1?
- Should core-only combat testing become a formal debug mode?
- What exact gameplay state owns death sequence triggering?
- When should the results/loss popup become required for release?
- Should early Pre-Alpha death return to main menu temporarily, or always route through sanctuary once home flow exists?

---

# Final Rule

Gameplay readability comes first.

The soul core must remain readable.

Enemy projectiles must remain readable.

The player body, sky, VFX, UI, and environment must support the core gameplay language instead of hiding it.
