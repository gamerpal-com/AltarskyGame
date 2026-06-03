# AltarSky Project Milestones

> Documentation maintenance note:
> If this milestone document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md` — update if the milestone changes Pre-Alpha 0.1 history.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if the milestone changes release readiness or completion state.
> - `docs/planning/roadmap.md` — update if the milestone changes current direction, next priorities, or future planning.
> - `docs/sprints/current_sprint.md` — update if active sprint completed work should become a milestone or if milestone work creates follow-up tasks.
> - Related `docs/systems/` and `docs/game_flow/` docs — update if the milestone reflects current system or flow behavior.
>
> This document is the high-level historical timeline. Detailed current behavior belongs in system and game-flow docs.


---

# Historical Development Timeline

## Q1 2026 — Foundation Prototype Phase

### Project Initialization

- Godot project created
- Repository structure established
- Initial mobile portrait prototype created
- Early player movement experiments
- Basic scene architecture established

### Player Movement System v1

- Touch and drag movement implemented
- Screen-bound movement restrictions
- Portrait orientation support
- Mobile input testing
- Basic flight controls validated

### Authentication System v1

- Guest account creation
- Device fingerprint generation
- Session persistence
- Local authentication save file system
- Backend authentication integration

### Session Refresh System

- Refresh token architecture
- Automatic token renewal
- Authentication recovery handling
- Refresh timer implementation

### Debug Infrastructure

- GlobalLogger autoload
- Runtime logging system
- Debug overlay
- In-game console viewer
- Mobile debugging tools


---

## Q2 2026 — Gameplay & Camera Phase

### Camera System v1

- Camera follow behavior
- Screen corridor testing
- Player position constraints
- Movement smoothing

### Zoom Management System

- Multi-stage zoom architecture
- Zoom state management
- Transition tweening
- Screen zone testing

### Debug Console System Overhaul 2026-06-01

- Debug console performance issue identified during gameplay profiling
- Logger signal path separated from expensive UI rendering
- Log levels added: ERROR, WARNING, SYSTEM, INFO, VERBOSE
- Filtered debug display added
- Snapshot-based debug console behavior implemented
- Optional live log display added
- Progressive log loading added
- Visible log buffer capped to prevent indefinite growth
- Mobile-friendly debug filter buttons added
- Debug UI updated with Refresh, All, Live, Errors, Warn, System, Info, and Verb controls
- Debugger documentation updated


---

## Q2 2026 — Environmental Rendering Phase

### 2.5D Rendering Research

- Perspective camera experiments
- Sprite3D validation
- Pixel art rendering tests
- HD-2D visual direction established

### Skyflow Director Architecture

- Environmental streaming design
- Layered world architecture
- Atmospheric depth planning
- Spawn layer specification

### Atmospheric Environment Framework

- Sky lighting system
- Day/night controls
- Layer planning
- Environmental rendering framework

### Floating Island Diorama Prototype

- Multi-layer island rendering
- Cloud layer integration
- Parallax depth experimentation
- Flight corridor visualization

### Documentation Foundation

- System documentation framework
- Rendering documentation
- Gameplay documentation
- Art pipeline documentation
- Future systems planner
- Documentation standards

### Sky Layer System v1

- Layer-based environmental architecture
- Dynamic cloud spawning
- Asset recycling
- Spawn distribution system
- Spawn jitter controls
- Anti-stacking logic
- Directional layer movement
- Inspector-driven configuration
