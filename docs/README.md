# Altarsky Documentation

## Overview

This directory contains technical documentation for Altarsky’s engine systems, gameplay architecture, rendering pipeline, networking systems, and development workflows.

The project is currently transitioning from a 2D prototype into a custom 2.5D Sprite3D rendering pipeline using Godot 4.

---

# Documentation Structure

## systems/
Core engine subsystems and orchestration frameworks.

## rendering/
Rendering architecture and visual pipeline documentation.

## gameplay/
Gameplay systems and player logic.

## networking/
Backend and authentication systems.

## art_pipeline/
Pixel art standards and rendering specifications.

## devlog/
Internal development milestones and implementation history.

---

# Current Engine Direction

Altarsky is being developed around a custom 2.5D environmental rendering pipeline featuring:

- Sprite3D environments
- Layered atmospheric depth
- Dynamic floating island streaming
- Perspective-based parallax simulation
- Pixel-art driven rendering

---

# Current Major Systems

## Skyflow Director
Environmental orchestration framework responsible for layered world streaming and atmospheric depth simulation.

## Authentication Manager
Handles user authentication and backend login state.

## Global Logger
Centralized debugging and logging framework.

## Player Controller
Handles player movement, state management, combat states, and traversal systems.