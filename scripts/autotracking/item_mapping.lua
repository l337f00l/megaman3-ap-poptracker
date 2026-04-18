ITEM_MAPPING = {
	-- Weapons
	[1] = {{"needle_cannon", "toggle"}},
	[2] = {{"magnet_missile", "toggle"}},
	[3] = {{"gemini_laser", "toggle"}},
	[4] = {{"hard_knuckle", "toggle"}},
	[5] = {{"top_spin", "toggle"}},
	[6] = {{"search_snake", "toggle"}},
	[7] = {{"spark_shock", "toggle"}},
	[8] = {{"shadow_blade", "toggle"}},
	-- Boss Access Codes
	[257] = {{"needle_man_state", "progressive"}},
	[258] = {{"magnet_man_state", "progressive"}},
	[259] = {{"gemini_man_state", "progressive"}},
	[260] = {{"hard_man_state", "progressive"}},
	[261] = {{"top_man_state", "progressive"}},
	[262] = {{"snake_man_state", "progressive"}},
	[263] = {{"spark_man_state", "progressive"}},
	[264] = {{"shadow_man_state", "progressive"}},
	-- Doc Robot Access Codes
	[273] = {{"stage_doc_needle", "progressive"}},
	[275] = {{"stage_doc_gemini", "progressive"}},
	[279] = {{"stage_doc_spark", "progressive"}},
	[280] = {{"stage_doc_shadow", "progressive"}},
	-- Rush items
	[17] = {{"rush_coil", "toggle"}},
	[18] = {{"rush_marine", "toggle"}},
	[19] = {{"rush_jet", "toggle"}},
	-- Consumables: third element explicitly sets increment to 1,
	-- bypassing item_obj.Increment which PopTracker may calculate incorrectly
	[32] = {{"one_up",         "consumable", "1"}},
	[33] = {{"weapon_energy",  "consumable", "1"}},
	[34] = {{"health_energy",  "consumable", "1"}},
	[35] = {{"etank",          "consumable", "1"}},
}
