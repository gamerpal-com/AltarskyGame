# Skyflow Director

## Summary

Skyflow Director is Altarsky’s environmental orchestration system for the 2.5D sky-world rendering pipeline.

It controls layered world streaming, floating island spawning, atmospheric depth simulation, environmental motion, and player-safe traversal zones.

---

# Responsibilities

## Layered World Streaming
Controls environmental layers including:
- Far background islands
- Mid-distance drifting islands
- Near traversal islands
- Atmospheric layers
- Fog and cloud systems

## Spawn Management
Handles randomized spawning of environmental objects while respecting gameplay constraints.

## Flight Corridor Protection
Prevents islands and large objects from spawning directly inside the player's intended movement path.

## Atmospheric Depth Simulation
Creates the illusion of massive sky depth using:
- Scale
- Fog
- Color grading
- Movement speed differentials
- Layer spacing

## Environmental Motion
Controls:
- Drift speed
- Direction
- Layer velocity
- Cloud motion
- Environmental parallax

## Performance-Oriented Streaming
Will eventually support:
- Spawn culling
- Distance despawning
- Layer optimization
- Visibility management

---

# Planned Features

- Dynamic island randomization
- Weighted biome spawning
- Layer-specific movement rules
- Fog density control
- Cloud simulation
- Atmospheric color profiles
- Event-driven environmental hazards
- Weather systems