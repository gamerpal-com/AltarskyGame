# Debug Console System

## Purpose

The Debug Console System provides runtime visibility into the state of the ALTARSKY prototype.

It exists to help developers monitor:

- Player state
- Zone changes
- Camera zoom changes
- Authentication events
- Debug actions
- System initialization
- Future gameplay events

The system acts as a centralized development and troubleshooting tool.

---

## Primary Files

```text
scripts/_core/Logger.gd
scripts/ui/DebugPanel.gd
scripts/ui/debug_button.gd
scripts/ui/ZoneOverlay.gd
Global Logger

The Logger is implemented as a global singleton.

Primary file:

scripts/_core/Logger.gd

The logger provides a centralized location for development output.

Example uses:

Authentication events
Player state changes
Zone changes
Zoom changes
System startup
Debug actions

The goal is to avoid scattered print statements throughout the project.

Debug Panel

The Debug Panel displays logger output inside the game.

Primary file:

scripts/ui/DebugPanel.gd

Current responsibilities:

Display runtime log messages
Scroll through log history
Toggle visibility
Assist prototype testing
Debug Toggle Button

Primary file:

scripts/ui/debug_button.gd

The debug button allows developers to:

Show debug information
Hide debug information

This keeps the testing interface accessible without 
permanently occupying screen space.

Zone Overlay

Primary file:

scripts/ui/ZoneOverlay.gd

The zone overlay visualizes the player's screen zones.

Current zones:

LEFT
MIDDLE
RIGHT

The overlay assists with:

Zone testing
Camera tuning
Input testing
Future spawn testing
Current Responsibilities

The Debug Console System currently owns:

Runtime logging
Debug panel display
Zone overlay rendering
Debug visibility controls
Development diagnostics
Prototype Status

The current implementation is designed for development support.

It is not intended to ship in its current form.

Some features may be:

Removed
Hidden behind developer mode
Disabled in release builds
Future Expansion

Future debug features may include:

FPS display
Entity counts
Active projectile counts
Memory usage
Spawn visualization
Collision visualization
SkyFlow Director visualization
Network diagnostics
Authentication diagnostics
Performance profiling
Long-Term Goal

The Debug Console System should become the primary tool for 
diagnosing issues during development.

All major systems should eventually be able to report 
meaningful information through the logger rather than relying on
 temporary print statements.
