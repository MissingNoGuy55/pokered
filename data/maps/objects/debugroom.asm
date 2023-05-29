DebugRoom_Object:
	db $f ; border block

	def_warp_events
	warp_event 25, 31, PALLET_TOWN, 3

	def_bg_events

	def_object_events
	object_event 20, 18, SPRITE_SUPER_NERD, STAY, RIGHT, 1, OPP_SUPER_NERD, 12
	object_event 20, 20, SPRITE_SUPER_NERD, STAY, RIGHT, 2, OPP_SUPER_NERD, 11
	object_event 13, 9, SPRITE_POKE_BALL, STAY, NONE, 3, MOON_STONE
	object_event 12, 9, SPRITE_POKE_BALL, STAY, NONE, 4, HP_UP

	def_warps_to DEBUGROOM
