# Altarsky Documentation

## Overview

This directory contains technical documentation for Altarsky's engine systems, gameplay architecture, rendering systems, networking, development workflows, and production planning.

Altarsky is a 2D vertical-scrolling fantasy bullet-hell RPG built in Godot 4.

The project focuses on atmospheric world-building through layered parallax backgrounds, floating sky kingdoms, dynamic day/night cycles, modular environmental systems, and pixel-art driven gameplay.

---

# Documentation Structure

## systems/
Core engine subsystems and orchestration frameworks.

## rendering/
Rendering architecture, sky systems, parallax systems, shaders, and visual effects.

## gameplay/
Gameplay systems, combat systems, progression systems, enemies, bosses, and player mechanics.

## networking/
Backend services, authentication systems, API integration, and account systems.

## art_pipeline/
Pixel art standards, animation guidelines, asset specifications, and production workflows.

## devlog/
Internal development milestones and implementation history.

---

# Current Engine Direction

Altarsky uses a layered 2D rendering architecture built around:

- Multi-layer parallax environments
- Dynamic day/night sky cycles
- Procedural atmospheric effects
- Floating island environments
- Modular nebula and cloud systems
- Pixel-art sprites and animation
- Portrait-mode vertical scrolling gameplay

The project is no longer pursuing the experimental 2.5D Sprite3D rendering pipeline.

---

# Current Major Systems

## Sky System
Controls day/night transitions, atmospheric lighting, starfields, nebulae, cloud layers, fog effects, celestial bodies, and environmental mood.

## World Streaming
Manages spawning and movement of environmental layers, floating islands, structures, and atmospheric elements.

## Authentication Manager
Handles user authentication and backend login state.

## Global Logger
Centralized debugging and logging framework.

## Player Controller
Handles movement, combat, abilities, animation state management, and gameplay interactions.

---

# Design Philosophy

Altarsky prioritizes atmosphere, emotional pacing, visual depth, and memorable experiences over graphical realism.

The goal is to create a dreamlike fantasy sky world filled with floating civilizations, cosmic vistas, exploration, and intense bullet-hell encounters.