# ============================================================
# ScreenZoneHelper
#
# Purpose:
# Splits the screen into simple horizontal zones.
#
# This allows other systems to ask:
#
# "Is something on the left side?"
# "Is something in the middle?"
# "Is something on the right?"
#
# Current Uses:
# - Cloud spawning
# - Environmental movement
#
# Future Uses:
# - Camera systems
# - Enemy spawning
# - UI positioning
# - Skyflow Director logic
#
# The helper does NOT move anything.
# It only reports which zone a position belongs to.
# ============================================================

extends Node

class_name ScreenZoneHelper


# ============================================================
# Default Zone Splits
#
# The screen is divided like this:
#
# |----LEFT----|---MIDDLE---|----RIGHT----|
# 0%          33%          66%         100%
#
# These values can be overridden when calling
# get_horizontal_zone().
# ============================================================

const DEFAULT_LEFT_SPLIT := 0.33
const DEFAULT_RIGHT_SPLIT := 0.66


# ============================================================
# Horizontal Zones
#
# LEFT
# Something is on the left side of the screen.
#
# MIDDLE
# Something is near the center of the screen.
#
# RIGHT
# Something is on the right side of the screen.
# ============================================================

enum HorizontalZone {
	LEFT,
	MIDDLE,
	RIGHT
}


# ============================================================
# Returns which horizontal zone a position belongs to.
#
# Example:
#
# Screen width = 1080
#
# x = 100
# Returns LEFT
#
# x = 540
# Returns MIDDLE
#
# x = 1000
# Returns RIGHT
#
# This function performs no movement.
# It only classifies a position.
# ============================================================

static func get_horizontal_zone(
	x_position: float,
	screen_width: float,
	left_split: float = DEFAULT_LEFT_SPLIT,
	right_split: float = DEFAULT_RIGHT_SPLIT
) -> HorizontalZone:

	# Safety check.
	# If the screen width is invalid,
	# default to the middle zone.
	if screen_width <= 0.0:
		return HorizontalZone.MIDDLE

	# Position falls within the left zone.
	if x_position < screen_width * left_split:
		return HorizontalZone.LEFT

	# Position falls within the right zone.
	if x_position > screen_width * right_split:
		return HorizontalZone.RIGHT

	# Everything else is considered middle.
	return HorizontalZone.MIDDLE