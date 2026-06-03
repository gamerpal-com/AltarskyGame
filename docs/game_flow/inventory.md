# Inventory Flow

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if inventory-flow responsibilities, source-of-truth routing, or document relationships change.
> - `docs/sprints/current_sprint.md` — update when inventory tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if inventory behavior becomes required for Pre-Alpha 0.1 scope or release readiness.
> - `docs/game_flow/home.md` — update when inventory affects sanctuary/home preparation, vaulting, recovery, or post-run flow.
> - `docs/game_flow/gameplay.md` — update when inventory affects active runs, carried items, death loss, or reward behavior.
> - `docs/game_flow/game_state_map.md` — update when inventory state changes player flow, post-run flow, sanctuary flow, or run preparation.
> - `docs/planning/roadmap.md` — update if inventory becomes an active milestone or future release priority.
> - Related `docs/systems/` docs — update when inventory has a real implementation system.
>
> Do not update this document in isolation when inventory changes affect gameplay, home/sanctuary, death loss, run rewards, release scope, or planning direction.

---

# Purpose

This document describes the planned inventory flow for AltarSky.

Inventory is not the current Pre-Alpha 0.1 focus, but it is important to preserve the direction because AltarSky uses risk, carried items, vaulting, death loss, and home/sanctuary preparation.

---

# Current Status

Inventory flow is planned.

A full inventory system is not currently implemented.

This document is a starter flow document to prevent inventory-related ideas from being lost or mixed into unrelated docs.

---

# Core Inventory Direction

AltarSky rewards/items should eventually exist in three broad states:

1. Earned during the current run.
2. Carried by the player from previous runs or rounds.
3. Stored safely in permanent vault/home storage.

Current design direction:

- Items carried on the player are at risk.
- On death, carried inventory and temporary upgrades may be lost.
- Permanent progression should not be lost once safely committed/vaulted.
- Serious long-term progression should generally require returning home/sanctuary.
- Newly earned long-term rewards should not become safely permanent until successfully returned.

---

# Home / Sanctuary Relationship

Home/sanctuary is the safe preparation and storage space.

Inventory should eventually connect to:

- Vaulting valuables.
- Preparing carried items.
- Reviewing post-run losses.
- Healing/upgrading pets.
- Choosing what to risk in the next run.
- Applying permanent upgrades after returning safely.

See:

- `docs/game_flow/home.md`

---

# Gameplay Relationship

During gameplay, inventory may affect:

- Temporary powerups.
- Carried items.
- Risk/reward decisions.
- Death loss.
- Run rewards.
- Return-home decisions.

Gameplay should clearly distinguish:

- What is temporary.
- What is carried and at risk.
- What has been safely committed to home/vault storage.

See:

- `docs/game_flow/gameplay.md`

---

# Death / Loss Relationship

Death should eventually trigger a post-run consequence review.

That review may include:

- Items lost.
- Temporary upgrades lost.
- Score/rank damage.
- Rewards preserved, if any.
- What remains safely stored at home.

This should connect to the sanctuary result popup.

See:

- `docs/game_flow/home.md`
- `docs/game_flow/game_state_map.md`
- `docs/systems/player_soul_core.md`

---

# Pre-Alpha 0.1 Scope

Inventory is likely deferrable for Pre-Alpha 0.1 unless needed for the minimal gameplay loop.

In scope for now:

- Preserve inventory direction in documentation.
- Avoid designing systems that contradict death-loss/home-vault direction.
- Keep future inventory flow discoverable.

Deferrable:

- Full inventory UI.
- Full vault system.
- Item carry selection.
- Permanent upgrade application flow.
- Detailed item database.
- Pet inventory integration.
- Full loss/recovery popup details.

---

# Open Questions

- When should inventory become active scope?
- Should Pre-Alpha 0.1 include any inventory placeholder?
- What exactly counts as carried inventory versus current-run loot?
- What is lost on death in the first playable version?
- How should vaulting be represented in UI?
- Should inventory be a system doc, game-flow doc, or both once implemented?

---

# Final Rule

Inventory should support AltarSky's risk/reward loop.

Carried items create risk.

Home/vault storage creates safety.

Death should clearly communicate what was lost and what was preserved.
