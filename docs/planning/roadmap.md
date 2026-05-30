# ALTARSKY Roadmap

## Purpose

This document tracks the current development direction for ALTARSKY.

It separates completed work, active work, near-term goals, merge milestones, and shelved future systems.

---

## Current Branch

```text
feature/stars-v1

This branch is currently being used as the active prototype 
development branch.

Despite the branch name, stars are not the current priority.

Current focus is:

Documentation cleanup
Sky lighting foundation
Parallax clouds
Parallax floating islands
Core gameplay systems
Stable Branch
main

The main branch should remain stable.

Major prototype work should be completed on feature branches before 
merging into main.

Completed Foundation

The following systems are implemented and documented:

Main Scene Controller
Player Controller
Auth System
Projectile Prototype
UI System
Debug Console System
Sky Lighting System V1
Shelved Future Documentation Planner
Active Work

Current active work:

Documentation cleanup
Roadmap creation
Planning cleanup before Sky Depth System
Next Development Target
Sky Depth System V1

Goal:

Create the first version of visual sky depth using parallax layers.

Planned features:

Far cloud layer
Mid cloud layer
Near cloud / fog layer
Distant floating island layer
Mid-distance floating island layer
Vertical scrolling movement
Basic wrapping / recycling
Inspector-exposed speed controls

This system should prove the illusion of flying upward through a 
layered sky world.

Merge Milestone

The current branch should be considered for merge into main when 
the following are complete:

Sky Lighting System V1 works
Sky shader is organized under shaders/sky
Core prototype systems are documented
Shelved future documentation exists
Roadmap exists
Sky Depth System V1 works
Clouds scroll vertically
Floating islands scroll vertically
Camera zoom does not break sky/background rendering
Player remains readable over sky layers
Game runs without major errors
After Merge

After merging this milestone into main, future branches should be created for specific systems.

Possible next branches:

feature/enemy-system-v1
feature/projectile-framework-v1
feature/skyflow-director-v1
feature/game-state-flow-v1
Shelved / Later

The following are not current priorities:

Stars
Nebulae
Advanced celestial effects
Guild systems
Marketplace systems
PvP systems
Endgame systems

These are tracked separately in:

docs/planning/shelved_future_documentation.md
Notes

The roadmap is expected to change.

This document should be updated whenever the active development focus 
changes or a major milestone is completed.
