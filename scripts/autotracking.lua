
-- Configuration
ENABLE_DEBUG_LOG = false
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true
AUTOTRACKER_ENABLE_DEBUG_LOGGING = false
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = false
AUTOTRACKER_ENABLE_DEBUG_LOGGING_SNES = false

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
print("---------------------------------------------------------------------")
print("")

require("scripts/settings")
-- loads the AP autotracking code
require("scripts/autotracking/archipelago")
