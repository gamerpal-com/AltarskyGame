# 2.5D Rendering Pipeline

## Summary

Altarsky uses a 2.5D rendering pipeline built in Godot 4 using Sprite3D nodes, perspective camera depth, and atmospheric layering.

## Current Rendering Method

Renderer:

- Compatibility

Reason:

- Forward+ caused Sprite3D transparency/rendering issues during testing.
- Compatibility correctly rendered pixel-art Sprite3D assets.

## Core Components

- Sprite3D island assets
- Perspective Camera3D
- WorldEnvironment
- Layered depth positioning
- Atmospheric color background
- Future fog and cloud systems

## Current Validated Features

- Sprite3D pipeline works
- Pixel-art imports correctly
- Perspective camera works
- Depth layering works
- Multiple floating islands work
- Atmospheric color direction works
- 2.5D illusion works

## Pending

- Fog tuning
- Glow testing
- Cloud layers
- Distance filtering
- Island movement engine
- Randomized spawning