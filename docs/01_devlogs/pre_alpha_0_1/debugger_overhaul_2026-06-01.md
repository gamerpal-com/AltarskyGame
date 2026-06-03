# Debugger Overhaul — 2026-06-01

> Documentation maintenance note:
> If this devlog is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md` — update if the debug-console overhaul timeline, outcome, or historical summary changes.
> - `docs/01_devlogs/project_milestones.md` — update if this overhaul becomes a milestone, changes milestone wording, or affects project timeline.
> - `docs/systems/debug_console.md` — update if the current debug console behavior, architecture, performance rules, logger/display separation, filters, or mobile controls change.
> - `docs/systems/ui_system.md` — update if debug UI controls, panel behavior, visibility rules, or UI performance behavior change.
> - `docs/sprints/current_sprint.md` — update when debug-console follow-up tasks, blockers, completed work, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if debug infrastructure readiness or performance affects Pre-Alpha 0.1 release scope.
>
> This is a historical devlog. Current behavior belongs in system docs; this file should preserve what happened and why.

## Summary

Completed a major overhaul of the in-game debug console during Pre-Alpha 0.1 development.

The debugger originally caused gameplay stutters when frequent log events were emitted,
especially during zone changes and while the debug console was open. 
The issue was traced to the debug UI update path, not the zone detection math itself.

The debugger now uses a safer architecture designed to protect gameplay performance 
while still preserving useful debug visibility.

---

## Why This Work Was Needed

The debug console is supposed to help diagnose problems.

It should not become a source of gameplay problems itself.

During testing, the game would freeze briefly when zone-change logs were generated.
 Later investigation showed that the issue was not the zone helper logic. 
The expensive part was the debug console display path.

The debugger needed to be rebuilt so it could remain useful without competing with
gameplay performance.

---

## Issues Discovered

- Zone-change logs caused noticeable gameplay freezes.
- The debug console caused stutters even when collapsed or hidden.
- Hidden UI was still receiving log signals and doing work.
- `RichTextLabel` text rendering caused engine-side frame spikes when logs were 
	refreshed too often.
- The visible log display could grow indefinitely when live appending messages.
- Auto-scroll behavior was lost during optimization and needed to be restored safely.
- Mobile debug filter buttons needed larger tap targets and clearer ON/OFF states.

---

## Investigation Notes

Profiler testing showed that the original debug console issue was not caused by 
expensive zone math.

The likely chain was:

```text
Zone change happens
↓
GlobalLogger emits log signal
↓
DebugPanel receives signal
↓
RichTextLabel updates or rebuilds text
↓
Frame hitch occurs
```

Further testing showed:

- Disabling Godot console printing helped slightly.
- Disabling the UI signal path helped significantly.
- Hidden debug UI still had performance cost before the overhaul.
- Script execution became very lean after optimization.
- Remaining heavy cost was mostly engine-side UI/text rendering.

---

## Logger Changes

`GlobalLogger` was updated to support log levels.

Added log levels:

- `ERROR`
- `WARNING`
- `SYSTEM`
- `INFO`
- `VERBOSE`

Legacy logging still works:

```gdscript
GlobalLogger.log("message")
```

New preferred leveled calls were added:

```gdscript
GlobalLogger.error("Missing player node")
GlobalLogger.warning("Spawn failed after max attempts")
GlobalLogger.system("Boss spawned")
GlobalLogger.info("Zone changed")
GlobalLogger.verbose("Cloud recycled")
```

The logger remains responsible for:

- Receiving log messages
- Assigning log levels
- Storing recent logs
- Keeping stored logs capped
- Optionally printing to Godot output
- Emitting a lightweight signal when a new log exists

The logger does not perform expensive UI display work.

---

## Debug Panel Changes

`DebugPanel.gd` was reworked so the visual console does not rebuild on every log event.

Implemented protections:

- Hidden console performs no visual work.
- Incoming logs do not directly rebuild the text display.
- Logs mark the display as dirty or enter a queue.
- Snapshot loading can happen progressively.
- Live display is optional and disabled by default.
- Visible log lines are capped.
- Overflow trimming prevents visible log growth from continuing indefinitely.
- Auto-scroll is handled through a controlled helper function.

---

## Display Modes

### Snapshot Mode

Snapshot mode is the default safe mode.

When the console opens:

1. It loads recent filtered logs.
2. It displays only enabled log levels.
3. It scrolls to the newest visible log if auto-scroll is enabled.
4. It does not continue updating live unless Live is enabled.

This prevents the console from constantly touching `RichTextLabel` during gameplay.

### Live Display Mode

Live mode is optional.

When enabled:

- New visible logs append while the console is open.
- Live updates are batched.
- Auto-scroll can move to the newest line.

Live mode is useful for active debugging, but it should remain off by default.

---

## Filter UI Added

Added in-game debug filter controls:

- Refresh
- All
- Live
- Errors
- Warn
- System
- Info
- Verb

Default filter behavior:

- Errors: ON
- Warnings: ON
- System: ON
- Info: OFF
- Verbose: OFF
- All: OFF
- Live: OFF

This allows the logger to record everything while the visible console only displays
useful information by default.

---

## Mobile UI Improvements

The debug filter buttons were adjusted for mobile usability.

Improvements included:

- Larger touch targets
- More spacing between buttons
- ON/OFF labels
- Stronger pressed/toggled visual state
- Refresh kept as a normal button
- Other filter controls configured as toggle buttons

This makes the debugger easier to use on mobile where finger taps are less precise 
than mouse clicks.

---

## Empty Log Placeholder

Added an empty display placeholder:

```text
Debug console ready. No important logs yet.
```

This message is not stored in `GlobalLogger`.

It only appears when no visible filtered logs exist.

When real visible logs load, the placeholder disappears.

---

## Performance Result

The original debug console produced severe frame spikes, including spikes around 80ms.

After the overhaul:

- Hidden debug console is effectively zero visual cost.
- Console no longer causes major gameplay stutters.
- Script profiler shows debugger logic running very lean.
- Visible log display is filtered and controlled.
- Live display is optional instead of forced.
- The debugger is now usable for deeper performance testing.

---

## Current Debugger Behavior

Default mode:

- Logger records messages.
- Debug panel displays only important logs.
- Console loads a filtered snapshot when opened.
- Console does not live-update unless Live is enabled.
- Show All can be enabled for deep debugging.
- Verbose logs remain hidden unless needed.
- Refresh reloads the current filtered snapshot.

This keeps the debugger useful without allowing it to compete with gameplay performance.

---

## Files Updated

Primary files affected:

```text
scripts/_core/Logger.gd
scripts/ui/DebugPanel.gd
scenes/UI_Main.tscn
docs/systems/debug_console_system.md
```

Documentation added:

```text
docs/01_devlogs/pre_alpha_0_1/debugger_overhaul_2026-06-01.md
```

---

## Remaining Notes

The debugger overhaul revealed that one performance issue was solved, but 
another periodic idle stutter still exists elsewhere.

The next performance investigation target is no longer the debugger.

Next likely target:

- Sky Layer Manager idle stutter
- Environmental asset recycling
- Spawn validation
- Layer-specific cloud/island behavior
- Possible engine-side rendering or asset recycling spikes

---

## Outcome

The debugger is now stable enough to support the next round of profiling and
 performance investigation.

This was a successful system evolution:

```text
Build simple debugger
↓
Use it during real testing
↓
Find performance problems
↓
Refactor into a safer architecture
↓
Document the new design
↓
Use improved debugger to investigate the next system
```
