# Sky and Parallax Rendering Pipeline

## Purpose

This document defines the rendering architecture used to create Altarsky's atmospheric sky-world environments.

The rendering system is designed to create the illusion of traveling upward through an infinite fantasy sky filled with floating islands, clouds, ruins, celestial bodies, stars, and cosmic phenomena.

The system prioritizes atmosphere, emotional impact, depth, and visual readability over graphical realism.

---

# Core Rendering Philosophy

Altarsky is a 2D vertical-scrolling fantasy bullet-hell RPG.

The world is rendered using layered 2D elements combined through parallax motion, atmospheric blending, transparency, color grading, and dynamic environmental transitions.

The objective is to create:

* Scale
* Wonder
* Verticality
* Atmospheric depth
* Dreamlike visual experiences

without requiring a fully simulated 3D world.

---

# Layer Hierarchy

Back-to-front rendering order:

1. Base Sky Color
2. Atmospheric Gradient
3. Distant Starfield
4. Near Starfield
5. Distant Nebula Layer
6. Near Nebula Layer
7. Distant Cloud Layer
8. Floating Island Layer (Far)
9. Floating Island Layer (Mid)
10. Floating Island Layer (Near)
11. Structures and Ruins
12. Foreground Cloud Layer
13. Atmospheric Fog Layer
14. Gameplay Layer
15. UI Layer

---

# Day and Night Cycle

The environment uses a dynamic day/night system.

Major phases:

* Morning
* Day
* Sunset
* Night

All timing values are configurable through exposed variables.

No phase durations should be hardcoded.

Transitions should always:

* Interpolate smoothly
* Avoid abrupt visual changes
* Use easing curves
* Blend environmental colors gradually

---

# Sky System

The sky system controls:

* Base sky color
* Atmospheric gradients
* Sun visibility
* Moon visibility
* Star intensity
* Nebula visibility
* Cloud density
* Fog density
* Ambient color grading

The sky system serves as the primary environmental mood controller.

---

# Parallax System

Environmental depth is created through layered parallax scrolling.

Movement speeds increase as layers approach the camera.

Typical ordering:

Background:

* Stars
* Nebulae
* Distant haze

Midground:

* Large floating islands
* Waterfalls
* Structures

Foreground:

* Clouds
* Fog
* Atmospheric effects

The player remains visually centered while the world scrolls downward.

This creates the illusion of upward flight.

---

# Nebula System

Nebulae are constructed from modular fragments.

Fragments may include:

* Arcs
* Wisps
* Filaments
* Clusters
* Haze patches
* Connector structures

Fragments may be:

* Rotated
* Scaled
* Flipped
* Layered

to create emergent formations.

Large static painted nebula backgrounds should be avoided.

---

# Floating Island System

Floating islands exist in multiple depth bands.

Examples:

Far:

* Massive silhouettes
* Minimal detail

Mid:

* Major landmarks
* Readable structures

Near:

* Gameplay-adjacent scenery
* Strong visual detail

Each band uses independent parallax speeds.

---

# Visual Readability

Gameplay readability takes priority over environmental detail.

Environmental systems must never:

* Obscure enemy projectiles
* Hide enemy silhouettes
* Reduce player visibility

Visual effects should support gameplay rather than compete with it.

---

# Long-Term Goals

Future rendering systems may include:

* Dynamic weather
* Lightning storms
* Solar eclipses
* Blood moons
* Cosmic events
* Region-specific sky themes
* Environmental boss encounters

These systems should integrate through the Sky System rather than being implemented independently.

---

# Design Goal

The player should feel as though they are traveling through a living fantasy sky world filled with mystery, ancient civilizations, and cosmic beauty.

The environment should create memorable moments through atmosphere, motion, and emotional pacing rather than graphical complexity alone.
