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

Previous work established the foundational environmental systems, including cloud spawning, environmental asset recycling, spawn distribution, anti-stacking protection, atmospheric lighting, and island layer integration.

This sprint focuses on adding environmental depth, movement realism, zoom responsiveness, and lighting integration so the world begins to feel alive rather than functioning as a static background.

The end result should support the visual identity and atmosphere of AltarSky while establishing the foundation for future Skyflow Director development.

---

# Completed Before This Sprint

## Environmental Foundation

- ✓ Sky Lighting System v1
- ✓ Sky Layer Foundation
- ✓ Cloud Asset Integration
- ✓ Island Asset Integration
- ✓ Dynamic Asset Spawning
- ✓ Asset Recycling
- ✓ Spawn Distribution System
- ✓ Spawn Jitter System
- ✓ Anti-Stacking Protection
- ✓ Spawn Validation Logic
- ✓ Directional Layer Movement
- ✓ Inspector-Driven Configuration
- ✓ ScreenZoneHelper Utility

---

## Major Improvements Already Completed

- ✓ Fixed right-side spawn bias
- ✓ Fixed asset center-point spacing calculations
- ✓ Fixed long-runtime spawn distribution inconsistencies
- ✓ Improved recycle behavior for multiple movement directions
- ✓ Improved asset spacing reliability
- ✓ Improved environmental density consistency

---

---

## Supporting Work Completed During This Sprint

### Debug Console Overhaul

- ✓ Identified debugger-related performance issue during profiling
- ✓ Separated logger signal handling from expensive UI rendering
- ✓ Added log levels: ERROR, WARNING, SYSTEM, INFO, VERBOSE
- ✓ Added filtered debug display
- ✓ Added snapshot-based log display
- ✓ Added optional live log display
- ✓ Added progressive log loading
- ✓ Added capped visible log buffer
- ✓ Added mobile-friendly debug filter buttons
- ✓ Updated debugger, UI, milestone, and devlog documentation

This work was completed to make performance testing safer before continuing Sky Layer Manager optimization.

---

# Current Sprint Goals

## Movement Systems

- □ Per-Asset Drift
- □ Spawn-Zone Awareness
- □ Layer Movement Profiles

---

## Environmental Depth

- □ Multi-Layer Cloud Tuning
- □ Far Cloud Layer Pass
- □ Mid Cloud Layer Pass
- □ Near Cloud Layer Pass

---

## Integration

- □ Zoom Integration
- □ Lighting Integration

---

## Validation

- □ Environmental MVP Review
- □ Sky Layer Manager Performance Review
- ✓ Debugger Performance Review
- □ Identify Remaining Sky Layer Manager MVP Blockers

---

# Design Decisions

## Clouds

Clouds represent atmospheric movement and weather.

Requirements:

- Horizontal drift enabled
- Spawn-zone awareness enabled
- Speed variation allowed
- Future rotation support possible

Clouds should feel alive and naturally flowing through the sky.

---

## Islands

Islands represent terrain and landmarks within the world.

Requirements:

- Horizontal drift disabled
- Terrain-like movement behavior
- Stable positioning
- Future streaming support

Islands should feel massive and grounded rather than behaving like weather.

---

## Future Layers

Future environmental layers should be configurable through the Sky Layer Manager rather than requiring separate systems.

Examples:

- Fog
- Debris
- Atmospheric particles
- Flying creatures
- Environmental effects

Layer behavior should be controlled through configuration rather than hardcoded logic whenever possible.

---

# Known Issues

## Rotation-Aware Spacing

Rotation itself is functioning correctly.

The remaining issue is that spacing calculations do not currently account for rotated asset bounds.

Rotation-aware spacing calculations will be required before rotational variance can be safely enabled on larger environmental assets.

## Idle Performance Spike

A periodic stutter still occurs while the game is idle.

The debugger was investigated first and significantly optimized.

The remaining idle spike appears to be unrelated to the debug console and 
should be investigated next through the Sky Layer Manager, 
environmental asset recycling, spawn validation, layer tuning, or rendering behavior.
---

## Spawn Zone Tracking

Current ScreenZoneHelper logic assumes visible screen bounds.

Future testing may require support for tracking environmental assets before they enter the visible play area.

This is especially relevant for island layers and larger environmental objects.

---

## System Integration

The following systems currently exist independently and still require integration:

- Sky Layer Manager
- Zoom System
- Sky Lighting System

This sprint is responsible for connecting these systems together.

---

# Success Condition

This sprint is considered complete when:

- Clouds feel natural and atmospheric.
- Islands feel stable and terrain-like.
- Layer depth convincingly creates a sense of scale.
- Zoom levels affect environmental presentation.
- Lighting affects environmental presentation.
- The sky world feels alive and visually convincing.
- The visual identity of AltarSky is clearly recognizable.

At that point the Sky Layer Manager MVP will be considered feature complete and ready for transition into future Skyflow Director development.

---
## Documentation / Workflow System Work

This sprint temporarily includes documentation infrastructure cleanup and developer workflow design before returning to Sky Layer Manager implementation.

### Completed

- [x] Confirmed real Godot project path and fixed duplicate-folder confusion.
- [x] Reorganized docs into final folder structure:
  - `docs/00_ReadMeFirst/`
  - `docs/01_devlogs/`
  - `docs/game_flow/`
  - `docs/planning/`
  - `docs/release_tracker/`
  - `docs/sprints/`
  - `docs/systems/`
- [x] Fixed `docs/00_ReadMeFirst/00_documentation_guide.md` Markdown structure.
- [x] Committed documentation structure cleanup separately from code changes.
- [x] Split remaining code/scene work into clean commits.

### Active Documentation Tasks

- [ ] Design the AltarSky developer operating system.
- [ ] Create the final `00_ReadMeFirst/` pyramid docs:
  - `docs/00_ReadMeFirst/00_start_here.md`
  - `docs/00_ReadMeFirst/01_documentation_guide.md`
  - `docs/00_ReadMeFirst/02_project_document_map.md`
  - `docs/00_ReadMeFirst/03_development_workflow.md`
  - `docs/00_ReadMeFirst/templates/current_sprint_template.md`
- [ ] Reorganize `docs/sprints/current_sprint.md` so it tracks active tasks, completed tasks, decisions, blockers, deferred ideas, documentation TODOs, and sprint closeout.
- [ ] Recreate `docs/systems/player_soul_core.md` in the correct repo.
- [ ] Update related docs affected by the soul core system.
- [ ] Decide where idea capture belongs: sprint doc, planning doc, or separate idea inbox.

### Deferred Notes

- Developer workflow should help the assistant keep the user focused, catch out-of-scope ideas, suggest deferral instead of derailment, and remind about documentation only at natural stopping points.
- Sprint closeout must preserve completed work instead of deleting it.
- Completed sprint work should feed devlogs, project milestones, release tracker, systems docs, game-flow docs, and planning docs.

---

# Next Planned Sprint


## Skyflow Director Foundation

Planned focus:

- Environmental orchestration
- Layer coordination
- Island streaming
- Corridor protection
- World-scale environmental management

The Skyflow Director will build on top of the Sky Layer Manager rather than replacing it.
