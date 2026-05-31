# Current Sprint

## Sprint Name

Sky Layer Manager Depth & Lighting

## Branch

feature/pre-alpha-0.1-sky-layer-manager-depth-lighting

## Status

In Progress

---

# Sprint Purpose

The purpose of this sprint is to transform the Sky Layer Manager from a functional environmental spawning system into a convincing atmospheric world rendering system.

Previous work established the foundational environmental systems including cloud spawning, environmental asset recycling, spawn distribution, anti-stacking protection, atmospheric lighting, and island layer integration.

This sprint focuses on adding environmental depth, movement realism, zoom responsiveness, and lighting integration so the world begins to feel alive rather than functioning as a static background.

The end result should support the visual identity and atmosphere of AltarSky while establishing the foundation for future Skyflow Director development.

---

# Completed Before This Sprint

## Environmental Foundation

✓ Sky Lighting System v1

✓ Sky Layer Foundation

✓ Cloud Asset Integration

✓ Island Asset Integration

✓ Dynamic Asset Spawning

✓ Asset Recycling

✓ Spawn Distribution System

✓ Spawn Jitter System

✓ Anti-Stacking Protection

✓ Spawn Validation Logic

✓ Directional Layer Movement

✓ Inspector-Driven Configuration

✓ ScreenZoneHelper Utility

---

## Major Improvements Already Completed

✓ Fixed right-side spawn bias

✓ Fixed asset center-point spacing calculations

✓ Fixed long-runtime spawn distribution inconsistencies

✓ Improved recycle behavior for multiple movement directions

✓ Improved asset spacing reliability

✓ Improved environmental density consistency

---

# Current Sprint Goals

## Movement Systems

□ Per-Asset Drift

□ Spawn-Zone Awareness

□ Layer Movement Profiles

---

## Environmental Depth

□ Multi-Layer Cloud Tuning

□ Far Cloud Layer Pass

□ Mid Cloud Layer Pass

□ Near Cloud Layer Pass

---

## Integration

□ Zoom Integration

□ Lighting Integration

---

## Validation

□ Environmental MVP Review

□ Performance Review

□ Identify Remaining Sky Layer Manager MVP Blockers

---

# Design Decisions

## Clouds

Clouds represent atmospheric movement and weather.

Requirements:

* Horizontal drift enabled
* Spawn-zone awareness enabled
* Speed variation allowed
* Future rotation support possible

Clouds should feel alive and naturally flowing through the sky.

---

## Islands

Islands represent terrain and landmarks within the world.

Requirements:

* Horizontal drift disabled
* Terrain-like movement behavior
* Stable positioning
* Future streaming support

Islands should feel massive and grounded rather than behaving like weather.

---

## Future Layers

Future environmental layers should be configurable through the Sky Layer Manager rather than requiring separate systems.

Examples:

* Fog
* Debris
* Atmospheric particles
* Flying creatures
* Environmental effects

Layer behavior should be controlled through configuration rather than hardcoded logic whenever possible.

---

# Known Issues

## Rotation-Aware Spacing

Rotation itself is functioning correctly.

The remaining issue is that spacing calculations do not currently account for rotated asset bounds.

Rotation-aware spacing calculations will be required before rotational variance can be safely enabled on larger environmental assets.

---

## Spawn Zone Tracking

Current ScreenZoneHelper logic assumes visible screen bounds.

Future testing may require support for tracking environmental assets before they enter the visible play area.

This is especially relevant for island layers and larger environmental objects.

---

## System Integration

The following systems currently exist independently and still require integration:

* Sky Layer Manager
* Zoom System
* Sky Lighting System

This sprint is responsible for connecting these systems together.

---

# Success Condition

This sprint is considered complete when:

* Clouds feel natural and atmospheric.
* Islands feel stable and terrain-like.
* Layer depth convincingly creates a sense of scale.
* Zoom levels affect environmental presentation.
* Lighting affects environmental presentation.
* The sky world feels alive and visually convincing.
* The visual identity of AltarSky is clearly recognizable.

At that point the Sky Layer Manager MVP will be considered feature complete and ready for transition into future Skyflow Director development.

---

# Next Planned Sprint

Skyflow Director Foundation

Planned Focus:

* Environmental orchestration
* Layer coordination
* Island streaming
* Corridor protection
* World-scale environmental management

The Skyflow Director will build on top of the Sky Layer Manager rather than replacing it.
