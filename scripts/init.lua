ENABLE_DEBUG_LOG = true

local variant = Tracker.ActiveVariantUID
IS_ITEMS_ONLY = variant:find("itemsonly")

if ENABLE_DEBUG_LOG then
    print("Mega Man 3 AP Tracker - Debug logging enabled")
end

ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/layouts.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlus.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlusWrapper.lua")

Tracker:AddItems("items/items.json")
Tracker:AddMaps("maps/maps.json")

-- Robot Master stages
Tracker:AddLocations("locations/needle_man.json")
Tracker:AddLocations("locations/magnet_man.json")
Tracker:AddLocations("locations/gemini_man.json")
Tracker:AddLocations("locations/hard_man.json")
Tracker:AddLocations("locations/top_man.json")
Tracker:AddLocations("locations/snake_man.json")
Tracker:AddLocations("locations/spark_man.json")
Tracker:AddLocations("locations/shadow_man.json")

-- Stage Select map locations
Tracker:AddLocations("locations/stage_select.json")
Tracker:AddLocations("locations/doc_stage_select.json")
Tracker:AddLocations("locations/break_man_select.json")

-- Doc Robot stages
Tracker:AddLocations("locations/doc_needle.json")
Tracker:AddLocations("locations/doc_gemini.json")
Tracker:AddLocations("locations/doc_spark.json")
Tracker:AddLocations("locations/doc_shadow.json")

-- Wily Fortress stage select overview
Tracker:AddLocations("locations/wily_stage_select.json")

-- Wily Fortress individual stages
Tracker:AddLocations("locations/wily_1.json")
Tracker:AddLocations("locations/wily_2.json")
Tracker:AddLocations("locations/wily_3.json")
Tracker:AddLocations("locations/wily_4.json")
Tracker:AddLocations("locations/wily_5.json")
Tracker:AddLocations("locations/wily_6.json")

Tracker:AddLayouts("layouts/items_standard.json")
Tracker:AddLayouts("layouts/layouttabs.json")
Tracker:AddLayouts("layouts/tracker.json")

if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end

print("Mega Man 3 AP Tracker loaded.")
