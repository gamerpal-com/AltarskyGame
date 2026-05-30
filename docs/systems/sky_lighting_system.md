# Sky Lighting System

## Purpose

The Sky Lighting System controls ALTARSKY's current atmospheric lighting framework.

It is responsible for:

- Morning, Day, Sunset, and Night phase cycling
- Smooth sky color transitions
- Full-screen atmospheric gradient rendering
- Horizon glow rendering
- Player ambient tinting
- Camera-zoom independent sky display

This system is the first version of ALTARSKY's environmental lighting framework.

---

## Primary Files

```text
scenes/SkySystem.tscn
scripts/gameplay/skycyclecontroller.gd
shaders/sky/SkyGradient.gdshader
Scene Structure

The SkySystem scene currently contains:

SkySystem
├── BackgroundColor
└── GradientOverlay

BackgroundColor is a full-screen ColorRect used as the base sky color.

GradientOverlay is a full-screen ColorRect using SkyGradient.gdshader.

Main Scene Integration

The SkySystem is instanced into the main scene under a background CanvasLayer.

Current structure:

Main
└── CanvasLayer_Background
	└── SkySystem

The CanvasLayer prevents the sky from being affected by Camera2D zoom.

This keeps the background full-screen and stable while gameplay zoom changes.

Time Cycle

The system currently supports four lighting phases:

Morning
Day
Sunset
Night

Each phase has its own Inspector-exposed duration.

Current test values are short for rapid iteration.

Future production values should be tuned in:

docs/planning/sky_time_map.md
SkyCycleController

SkyCycleController.gd controls the runtime lighting cycle.

It tracks:

time_in_cycle
morning_duration
day_duration
sunset_duration
night_duration

Each frame, the controller:

Advances the cycle timer
Calculates the current phase blend
Updates the base sky color
Updates shader color parameters
Updates the player ambient tint
Gradient Shader

SkyGradient.gdshader creates the atmospheric gradient.

It uses runtime parameters for:

top_color
middle_color
horizon_color
bottom_color
horizon_position
horizon_strength

The shader creates:

Upper atmosphere color
Mid-atmosphere color
Bright horizon band
Lower atmosphere color
Subtle horizon glow
Player Ambient Tint

The system can tint the player based on the current time of day.

Current player tint phases:

Morning
Day
Sunset
Night

This helps the character visually belong to the environment.

The player reference is assigned through:

player_path

in the Godot Inspector.

Current Status

Sky Lighting System V1 is complete.

Implemented:

SkySystem scene
SkyCycleController script
SkyGradient shader
Full-screen gradient
Horizon glow
Day/night cycle
Player ambient tinting
CanvasLayer-based zoom isolation
Known Notes

The current gradient shader is good enough for prototype use.

Future polish may include:

Reduced banding
Subtle dithering
Noise-based atmospheric texture
Better night tuning
Better sunset tuning
Future Expansion

This system may later support:

Sun layer
Moon layer
Stars
Nebulae
Weather tinting
Atmospheric fog
Cloud color modulation
Time-based music transitions
Enemy behavior changes based on time of day

Stars and nebulae are intentionally postponed.

Current priority after this system is:

Parallax cloud layers
Parallax floating island layers
Sky depth illusion
Gameplay systems
