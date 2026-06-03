# Debug Console System

> Documentation maintenance note:
> If this system doc is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md` — update only if historical details about the overhaul need correction or clarification.
> - `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md` — update if debug-console changes become part of Pre-Alpha 0.1 history.
> - `docs/01_devlogs/project_milestones.md` — update if debug-console work becomes a milestone or changes milestone wording.
> - `docs/systems/ui_system.md` — update when debug panel UI, filter buttons, visibility, or UI performance behavior changes.
> - `docs/systems/main_scene_controller.md` — update when main-scene debug toggles, zone overlay control, or debug signal wiring changes.
> - `docs/sprints/current_sprint.md` — update when debug-console tasks, blockers, completed work, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if debug infrastructure readiness affects Pre-Alpha 0.1 scope.
>
> This document describes current debug-console behavior. Historical investigation details belong in the debugger overhaul devlog.


## Purpose

The Debug Console System provides runtime visibility into the state of the AltarSky prototype.

It exists to help developers monitor important system activity without relying on scattered temporary print statements.

The debug console is a development tool.

Its most important rule is:

**The debugger must never hurt gameplay performance.**

---

## Core Rule

The logger records information.

The debug panel displays information.

These are separate responsibilities.

`GlobalLogger` should stay cheap.

`DebugPanel` controls visual display.

Expensive UI work should never happen directly inside the logger.

---

## Primary Files

```text
scripts/_core/Logger.gd
scripts/ui/DebugPanel.gd
scripts/ui/debug_button.gd
scripts/ui/ZoneOverlay.gd
```

---

## GlobalLogger

Primary file:

```text
scripts/_core/Logger.gd
```

The logger is implemented as a global singleton.

It provides a centralized location for development output.

The goal is to avoid scattered `print()` statements throughout the project.

### Responsibilities

`GlobalLogger` is responsible for:

- Receiving log messages
- Assigning log levels
- Storing recent logs
- Keeping stored logs capped
- Optionally printing to Godot output
- Emitting a lightweight signal when a new log exists

`GlobalLogger` should not perform expensive UI work.

---

## Log Levels

The logger supports five log levels.

### ERROR

Used when something is broken.

Examples:

- Missing required node
- Failed save
- Failed load
- Broken system reference

Visible by default.

### WARNING

Used when something may be wrong.

Examples:

- Spawn failed after max attempts
- Missing optional asset
- Unexpected fallback behavior

Visible by default.

### SYSTEM

Used for important system events.

Examples:

- Debug console ready
- Scene loaded
- Boss spawned
- Save complete
- Return home available

Visible by default.

### INFO

Used for normal debug information.

Examples:

- Zone changed
- Camera zoom changed
- General runtime state changed

Hidden by default.

### VERBOSE

Used for noisy detailed debugging.

Examples:

- Cloud recycled
- Asset movement assigned
- Spawn attempt checked
- Per-asset direction assigned
- Frequent system details

Hidden by default.

Verbose logs should only be enabled when actively debugging a specific system.

---

## Logger Usage

Legacy log calls still work:

```gdscript
GlobalLogger.log("Zone changed")
```

This defaults to `INFO`.

Preferred leveled calls:

```gdscript
GlobalLogger.error("Missing player node")
GlobalLogger.warning("Spawn failed after max attempts")
GlobalLogger.system("Boss spawned")
GlobalLogger.info("Zone changed")
GlobalLogger.verbose("Cloud recycled")
```

---

## DebugPanel

Primary file:

```text
scripts/ui/DebugPanel.gd
```

The Debug Panel displays logger output inside the game.

### Responsibilities

`DebugPanel` is responsible for:

- Showing logs in-game
- Filtering visible log levels
- Loading log snapshots
- Optionally showing live logs
- Avoiding expensive UI work while hidden
- Preventing `RichTextLabel` updates from hurting gameplay

---

## Performance Design

The Debug Panel is designed around one rule:

**Gameplay comes first.**

To protect performance:

- Hidden console does no visual work.
- Incoming logs do not directly rebuild the text display.
- Logs mark the display as dirty or enter a queue.
- Snapshot loading can happen progressively.
- Live display is optional and off by default.
- Visible log lines are capped.
- Overflow trimming prevents the display from growing forever.
- Auto-scroll is handled through one controlled helper function.

This prevents frequent logs from creating gameplay stutters.

---

## Default Display Mode

The default mode is snapshot-based.

When the console opens:

1. It loads recent filtered logs.
2. It displays only enabled log levels.
3. It scrolls to the newest visible log if auto-scroll is enabled.
4. It does not continue updating live unless Live is enabled.

This prevents the console from constantly touching `RichTextLabel` during gameplay.

---

## Live Display Mode

Live Display is optional.

When enabled:

- New visible logs append while the console is open.
- Live updates are batched.
- Auto-scroll can move to the newest line.

Live mode is useful for active debugging but should remain off by default.

---

## Filter Controls

The in-game debug panel includes these controls:

- Refresh
- All
- Live
- Errors
- Warn
- System
- Info
- Verb

### Refresh

Reloads the current filtered snapshot.

This is not a toggle.

### All

Shows all log levels.

### Live

Allows visible logs to update while the console is open.

### Errors

Shows or hides `ERROR` logs.

### Warn

Shows or hides `WARNING` logs.

### System

Shows or hides `SYSTEM` logs.

### Info

Shows or hides `INFO` logs.

### Verb

Shows or hides `VERBOSE` logs.

---

## Default Filter State

Recommended default state:

- Errors: ON
- Warnings: ON
- System: ON
- Info: OFF
- Verbose: OFF
- All: OFF
- Live: OFF

This keeps important information visible while hiding noisy logs.

---

## Mobile UI Notes

The debug filter buttons are designed for mobile testing.

Buttons should use:

- Large touch targets
- Clear ON/OFF labels
- Obvious pressed state
- Enough spacing between controls

Refresh should remain a normal button.

All other filter buttons should be toggle buttons.

---

## Empty Log Message

If no visible logs exist, the debug panel displays:

```text
Debug console ready. No important logs yet.
```

This message is not stored in `GlobalLogger`.

It is only a UI placeholder.

When real visible logs load, the placeholder disappears.

---

## Zone Overlay

Primary file:

```text
scripts/ui/ZoneOverlay.gd
```

The zone overlay visualizes the player's screen zones.

Current zones:

- LEFT
- MIDDLE
- RIGHT

The overlay assists with:

- Zone testing
- Camera tuning
- Input testing
- Future spawn testing
- Screen-zone debugging

---

## Debug Toggle Button

Primary file:

```text
scripts/ui/debug_button.gd
```

The debug button allows developers to:

- Show debug information
- Hide debug information

This keeps the testing interface accessible without permanently occupying screen space.

---

## Current Responsibilities

The Debug Console System currently owns:

- Runtime logging
- Log levels
- Debug panel display
- Filtered log display
- Snapshot log display
- Optional live display
- Zone overlay rendering
- Debug visibility controls
- Development diagnostics
- Mobile-friendly debug controls

---

## Performance History

During Pre-Alpha 0.1 development, the debug console caused gameplay stutters.

The original issue was caused by frequent log events forcing hidden or visible UI updates.

The debugger was overhauled so that:

- Hidden console does no visual work.
- Logger signal handling stays cheap.
- `RichTextLabel` is not rebuilt on every log event.
- Log display is filtered by default.
- Live display is optional.
- Snapshot loading is progressive.
- Visible logs are capped.

After the overhaul, debugger-related frame spikes were significantly reduced.

Remaining performance investigations should focus on gameplay systems unless the console is explicitly placed into expensive live/debug modes.

---

## Prototype Status

The current implementation is designed for development support.

It is not intended to ship in its current form.

Some features may be:

- Removed
- Hidden behind developer mode
- Disabled in release builds
- Replaced with a lighter developer overlay

---

## Future Expansion

Future debug features may include:

- FPS display
- Entity counts
- Active projectile counts
- Memory usage
- Spawn visualization
- Collision visualization
- Sky Layer Manager visualization
- Skyflow Director visualization
- Network diagnostics
- Authentication diagnostics
- Performance profiling
- Per-system verbose toggles
- Search/filter box
- Export log button
- Color coding by log level
- Persistent debug settings

---

## Long-Term Goal

The Debug Console System should become the primary tool for diagnosing issues during development.

All major systems should eventually be able to report meaningful information through the logger instead of relying on temporary print statements.

The debugger should support deeper inspection without competing with gameplay performance.
