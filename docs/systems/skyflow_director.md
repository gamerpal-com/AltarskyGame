# Skyflow Director

## Summary

Skyflow Director is Altarsky's world orchestration and environmental streaming system.

It manages the spawning, movement, organization, and lifecycle of environmental objects such as floating islands, structures, atmospheric props, clouds, hazards, and biome-specific scenery.

Skyflow Director works alongside the Sky System, which is responsible for atmospheric rendering, environmental mood, and day/night transitions.

The purpose of Skyflow Director is to create the illusion of traveling upward through a vast living sky world while maintaining gameplay readability, performance, and environmental variety.

---

# Responsibilities

## Layered World Streaming

Controls environmental layers including:

* Far background islands
* Mid-distance islands
* Near environmental islands
* Structures and ruins
* Environmental props
* Atmospheric scenery
* Biome-specific set pieces

Objects are streamed in and out of the world as needed to maintain the illusion of an infinite sky environment.

---

## Spawn Management

Responsible for spawning environmental objects according to configurable rules.

Examples:

* Floating islands
* Ruins
* Bridges
* Waterfalls
* Environmental decorations
* Atmospheric props

Spawn logic should support weighted probabilities, biome restrictions, and future event systems.

---

## Flight Corridor Protection

Maintains safe traversal corridors for the player.

Responsibilities include:

* Preventing environmental objects from spawning directly on the player
* Preventing unavoidable obstruction patterns
* Maintaining readable navigation routes
* Preserving gameplay flow

Environmental generation should enhance gameplay rather than interfere with it.

---

## Environmental Depth Management

Creates the illusion of a vast layered sky world through:

* Parallax movement
* Layer separation
* Object scaling
* Spawn distribution
* Environmental density management
* Atmospheric interaction

Depth should be achieved through layered composition rather than true 3D simulation.

---

## Environmental Motion

Controls movement behavior for environmental objects.

Examples:

* Island drift
* Cloud movement
* Atmospheric motion
* Layer scrolling
* Environmental velocity variation

Each layer may have unique movement rules and speeds.

---

## Biome Management

Responsible for selecting and coordinating biome-specific environmental content.

Examples:

* Sky Ruins
* Celestial Gardens
* Ancient Floating Kingdoms
* Storm Fronts
* Cosmic Rift Zones
* Sacred Sanctuaries

Biome definitions determine:

* Environmental assets
* Island variants
* Structures
* Atmospheric props
* Hazard pools
* Weather behavior
* Event pools

Biomes should be capable of blending and transitioning smoothly when required.

---

## Event Coordination

Provides environmental support for world events.

Examples:

* Storm systems
* World encounters
* Environmental hazards
* Rare atmospheric events
* Boss encounter preparation
* Region-specific world states

Environmental events should be able to modify spawning behavior without requiring changes to the underlying streaming system.

---

## Performance-Oriented Streaming

Responsible for maintaining environmental performance through:

* Spawn culling
* Distance despawning
* Layer optimization
* Visibility management
* Object pooling
* Spawn budgeting

The system should scale cleanly across mobile and desktop hardware.

---

# Relationship To Sky System

Skyflow Director and Sky System serve different responsibilities.

## Skyflow Director Controls

* Island spawning
* Structure spawning
* Environmental streaming
* Biome selection
* Layer organization
* Environmental motion
* World events
* Traversal safety

## Sky System Controls

* Day/night cycle
* Sky colors
* Atmospheric gradients
* Starfields
* Nebulae
* Clouds
* Fog
* Sun and moon rendering
* Environmental mood

Skyflow Director may consume information from the Sky System when environmental behavior depends on the current time of day or atmospheric state.

---

# Planned Features

* Dynamic island randomization
* Weighted biome spawning
* Region-specific environmental themes
* Layer-specific movement rules
* Cloud simulation
* Weather systems
* Environmental hazards
* Rare world events
* Ancient structure generation
* Procedural landmark placement
* Seasonal environmental modifiers
* Boss arena preparation systems

---

# Design Goals

The player should feel as though they are traveling through a living fantasy sky world that extends infinitely beyond the visible screen.

The environment should continuously provide variety, scale, mystery, and atmosphere while preserving gameplay clarity and performance.

Skyflow Director exists to make the world feel alive, dynamic, and expansive without requiring a fully simulated world.
