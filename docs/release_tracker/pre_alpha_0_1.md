# Pre-Alpha 0.1

> Documentation maintenance note:
> If this release tracker is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/planning/roadmap.md` — update if Pre-Alpha 0.1 scope, direction, or priority changes.
> - `docs/release_tracker/release_roadmap.md` — update if milestone order, release goals, or release status changes.
> - `docs/sprints/current_sprint.md` — update if release requirements create, complete, defer, or block active sprint work.
> - `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md` — update during sprint/release closeout when completed work becomes historical record.
> - Related `docs/systems/` docs — update if release criteria depend on current system behavior.
> - Related `docs/game_flow/` docs — update if release criteria depend on player flow, menus, gameplay, death, sanctuary, or state transitions.
>
> This document tracks release readiness. It should stay aligned with the active sprint and roadmap.


## Release Goal

First Playable Sky-World Prototype

---

# Core Systems

## Project Foundation

✓ Project Setup

✓ Repository Setup

✓ Development Environment

✓ Core Project Architecture

---

## Authentication

✓ Guest Account Creation

✓ Device Fingerprinting

✓ Refresh Token Architecture

□ Session Persistence Verification

□ Guest Account Recovery Verification

□ Refresh Recovery Verification

---

## Player Systems

✓ Player Movement

✓ Input System

✓ Screen Boundary Protection

✓ Player Sprite Integration

✓ Basic Animation Support

✓ Player Soul Core design documented

□ Soul core separated from player sprite if practical for Pre-Alpha 0.1

□ Soul core readability validated over sky layers

□ True hitbox behavior reviewed against projectile system

□ Death / sanctuary return direction reviewed for Pre-Alpha 0.1 scope

---

## Camera & View

✓ Camera System

✓ Zoom System

✓ Zone Tracking

✓ Portrait Gameplay Support

---

## Debug Infrastructure

✓ Runtime Logging

✓ Debug Console

✓ Console Toggle

✓ Screen Zone Overlay

✓ Log Levels

✓ Debug Log Filtering

✓ Snapshot Log Display

✓ Optional Live Log Display

✓ Progressive Log Loading

✓ Mobile Debug Filter Controls

✓ Debug Console Performance Optimization

---

## User Interface

✓ Basic UI Foundation

---

# Environment

## Sky Lighting

✓ Sky Lighting System v1

✓ Atmospheric Rendering Foundation

---

## Sky Layer Manager

✓ Sky Layer Foundation

✓ Cloud Layer Foundation

✓ Island Layer Foundation

✓ Dynamic Asset Spawning

✓ Asset Recycling

✓ Spawn Distribution

✓ Spawn Jitter

✓ Anti-Stacking Protection

✓ Spawn Validation

✓ Directional Layer Movement

✓ Inspector Configuration

✓ ScreenZoneHelper

---

## Sky Layer Manager Completion

□ Per-Asset Drift

□ Spawn-Zone Awareness

□ Layer Movement Profiles

□ Multi-Layer Cloud Tuning

□ Island Layer Tuning

□ Zoom Integration

□ Lighting Integration

□ Skyflow Director Foundation

---

# Persistence

□ High Score Persistence v1

□ Session Persistence Verification

---

# Minimal Gameplay

□ Enemy v1

□ Projectile v1

□ Score Counter v1

---

# Main Menu

□ Main Menu v1

□ Play Button

□ Highest Score Display

---

# Documentation

✓ System Documentation Framework

✓ Development Logs

□ Release Tracker Established

□ Sprint Tracker Established

□ Documentation Pass Review

---

# Release Condition

Pre-Alpha 0.1 is complete when a player can:

* Launch the game
* Enter the main menu
* Start a play session
* Fly through a convincing atmospheric sky world
* Experience environmental depth
* Encounter a basic enemy
* Shoot projectiles
* Destroy enemies
* Earn score
* Return to the menu
* View a saved high score

The purpose of Pre-Alpha 0.1 is to demonstrate the core vision of AltarSky and establish the first complete playable gameplay loop.
