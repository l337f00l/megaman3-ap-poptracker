-- MM3 item mapping by item NAME
-- Format: item_name_in_AP = {tracker_code, type}

ITEM_MAPPING_BY_NAME = {
    -- Weapons
    ["Needle Cannon"]  = {"needle_cannon",   "toggle"},
    ["Magnet Missile"] = {"magnet_missile",  "toggle"},
    ["Gemini Laser"]   = {"gemini_laser",    "toggle"},
    ["Hard Knuckle"]   = {"hard_knuckle",    "toggle"},
    ["Top Spin"]       = {"top_spin",        "toggle"},
    ["Search Snake"]   = {"search_snake",    "toggle"},
    ["Spark Shot"]     = {"spark_shot",      "toggle"},  -- AP uses "Spark Shot" not "Spark Shock"
    ["Shadow Blade"]   = {"shadow_blade",    "toggle"},
    -- Rush
    ["Rush Coil"]      = {"rush_coil",       "toggle"},
    ["Rush Jet"]       = {"rush_jet",        "toggle"},
    ["Rush Marine"]    = {"rush_marine",     "toggle"},
    -- Consumables
    ["Energy Tank"]    = {"etank",           "consumable"},
    ["1-Up"]           = {"one_up",          "consumable"},
    ["Health Energy (L)"] = {"health_energy", "consumable"},
    ["Weapon Energy (L)"] = {"weapon_energy", "consumable"},
    -- Robot Master Stage Access
    ["Needle Man Stage"]  = {"needle_man_state", "progressive"},
    ["Magnet Man Stage"]  = {"magnet_man_state", "progressive"},
    ["Gemini Man Stage"]  = {"gemini_man_state", "progressive"},
    ["Hard Man Stage"]    = {"hard_man_state",   "progressive"},
    ["Top Man Stage"]     = {"top_man_state",    "progressive"},
    ["Snake Man Stage"]   = {"snake_man_state",  "progressive"},
    ["Spark Man Stage"]   = {"spark_man_state",  "progressive"},
    ["Shadow Man Stage"]  = {"shadow_man_state", "progressive"},
    -- Doc Robot Stage Access (correct stages: Needle, Gemini, Spark, Shadow)
    ["Doc Robot Needle Man Stage"] = {"stage_doc_needle", "progressive"},
    ["Doc Robot Gemini Man Stage"] = {"stage_doc_gemini", "progressive"},
    ["Doc Robot Spark Man Stage"]  = {"stage_doc_spark",  "progressive"},
    ["Doc Robot Shadow Man Stage"] = {"stage_doc_shadow", "progressive"},
    -- Wily
    ["Wily Stage Access"] = {"stage_wily", "toggle"},
}

ITEM_MAPPING = {}
