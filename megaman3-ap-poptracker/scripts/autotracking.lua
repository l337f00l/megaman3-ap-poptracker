-- Configuration
ENABLE_DEBUG_LOG = true
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true and ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:      ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:  ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
print("---------------------------------------------------------------------")
print("")

ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
