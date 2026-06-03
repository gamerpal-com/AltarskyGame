# Home / Sanctuary Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if home/sanctuary document responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when home/sanctuary tasks, completed work, blockers, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if home/sanctuary flow becomes part of Pre-Alpha 0.1 release criteria.
> - `docs/game_flow/gameplay.md` — update when gameplay death, run completion, return-home, or sanctuary transition behavior changes.
> - `docs/game_flow/game_state_map.md` — update when sanctuary/home states, transitions, death return, results popup, or preparation flow changes.
> - `docs/systems/player_soul_core.md` — update when death, revival, sanctuary wake-up, soul stabilization, or projection return behavior changes.
> - `docs/systems/ui_system.md` — update when sanctuary UI, results/loss popup, preparation UI, or post-death popup behavior changes.
> - `docs/systems/player_controller.md` — update when player control state changes during sanctuary wake-up, recovery, or preparation.
>
> Do not update this document in isolation when sanctuary flow changes affect gameplay death flow, UI, player state, soul core behavior, or release criteria.

---

# Purpose

This document describes the Home / Sanctuary flow.

The sanctuary is the player's recovery and preparation space.

It is also the intended destination after soul-core death, because death represents the collapse of the active astral projection rather than ordinary physical death.

---

# Sanctuary Role

The sanctuary/home space should eventually support:

- Recovery after death.
- Preparation for the next run.
- Post-run results.
- Loss/consequence review.
- Upgrade flow.
- Vault/storage flow.
- Pet/dragon management.
- Run planning.
- Soft return to future runs.

For now, this document mainly defines the death return relationship with the player soul core system.

---

# Death Return Rule

After fatal soul core rupture, the player should return to sanctuary through a soft cinematic transition.

The player should not be dropped straight into a hard game-over/replay menu.

Intended flow:

1. Soul core fractures during gameplay.
2. Astral projection ruptures.
3. Magical explosion plays.
4. Scene fades out.
5. Player fades in at sanctuary.
6. Player wakes, reforms, or stabilizes.
7. Results/loss popup appears.
8. Player reviews score, losses, rank damage, and consequences.
9. Player regains control in sanctuary.
10. Player prepares for the next run.

The popup belongs after the sanctuary wake-up moment, not before.

---

# Results / Loss Popup

The sanctuary results popup should eventually display:

- Score.
- What was lost.
- Rank damage.
- Run consequences.
- Items lost.
- Temporary upgrades lost.
- Rewards preserved, if any.
- Next preparation options.

This popup is part of the sanctuary recovery flow.

It should not interrupt the death cinematic before the player returns to sanctuary.

---

# Soul Core Relationship

The sanctuary return makes sense because:

- The soul core is the real player.
- The body is an astral projection.
- Death is projection rupture.
- The sanctuary can re-anchor or recover the soul.
- Revival/restabilization mechanics can naturally fit this flow later.

See:

- `docs/systems/player_soul_core.md`

---

# Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 does not need the full final sanctuary system.

For now, the important rules are:

- Death/sanctuary direction is documented.
- Hard game-over menu should not be treated as the final intended flow.
- If a temporary menu return is used, it should be marked temporary.
- Future sanctuary return should be preserved as the intended design direction.

Possible deferrals:

- Full sanctuary scene.
- Full wake-up animation.
- Full post-death consequence popup.
- Full upgrade/vault/preparation flow.
- Full revival/restabilization flow.

---

# Open Questions

- When does sanctuary become required in playable builds?
- Should Pre-Alpha 0.1 include a placeholder sanctuary screen?
- What temporary flow is acceptable before sanctuary exists?
- Should results/loss popup be implemented before or after home scene foundation?
- How should player control resume after sanctuary wake-up?

---

# Final Rule

The sanctuary is not just a menu.

It is the recovery and preparation space connected to AltarSky's soul/projection death logic.

Death should eventually return the player here through a soft cinematic flow.
