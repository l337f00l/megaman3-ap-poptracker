ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}

-- Helper: decrement a section's chest count (marks it as checked)
function check_section(section_path)
    local obj = Tracker:FindObjectForCode(section_path)
    if obj then
        if obj.AvailableChestCount and obj.AvailableChestCount > 0 then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
        end
    else
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print("[MM3 AP] Could not find section: " .. tostring(section_path))
        end
    end
end

-- Set a boss stage to "open" (stage 1 = colored portrait)
function set_stage_state_unlocked(statecode)
    local state = Tracker:FindObjectForCode(statecode)
    if state and state.CurrentStage == 0 then
        state.CurrentStage = 1
    end
end

-- Set a boss stage to "defeated" (stage 2 = X over portrait)
function set_stage_state_cleared(statecode)
    local state = Tracker:FindObjectForCode(statecode)
    if state then
        state.CurrentStage = 2
    end
end

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print("onClear called")
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}

    -- Reset all items
    for _, v in pairs(ITEM_MAPPING_BY_NAME) do
        local obj = Tracker:FindObjectForCode(v[1])
        if obj then
            if v[2] == "toggle" then
                obj.Active = false
            elseif v[2] == "progressive" then
                obj.CurrentStage = 0
            elseif v[2] == "consumable" then
                obj.AcquiredCount = 0
            end
        end
    end

    -- Reset all location sections (restore chest counts to full)
    for _, section_path in pairs(LOCATION_NAME_TO_SECTION) do
        local obj = Tracker:FindObjectForCode(section_path)
        if obj and obj.ChestCount then
            obj.AvailableChestCount = obj.ChestCount
        end
    end

    print("[MM3 AP] Cleared - ready for resync")
end

function onItem(index, item_id, item_name, player_number)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onItem: index=%s name=%s", index, item_name))
    end
    if not AUTOTRACKER_ENABLE_ITEM_TRACKING then return end
    if index <= CUR_INDEX then return end
    CUR_INDEX = index

    local v = ITEM_MAPPING_BY_NAME[item_name]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("[MM3 AP] Unknown item: %s", item_name))
        end
        return
    end

    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.CurrentStage == 0 then
                obj.CurrentStage = 1
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + 1
        end
    end
end

function onLocation(location_id, location_name)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("onLocation: id=%s name=%s", location_id, location_name))
    end
    if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then return end

    -- ---------------------------------------------------------------
    -- Boss portrait state updates (locked -> open -> defeated)
    -- ---------------------------------------------------------------
    local boss_defeats = {
        ["Needle Man Boss"]  = "needle_man_state",
        ["Magnet Man Boss"]  = "magnet_man_state",
        ["Gemini Man Boss"]  = "gemini_man_state",
        ["Hard Man Boss"]    = "hard_man_state",
        ["Top Man Boss"]     = "top_man_state",
        ["Snake Man Boss"]   = "snake_man_state",
        ["Spark Man Boss"]   = "spark_man_state",
        ["Shadow Man Boss"]  = "shadow_man_state",
    }
    if boss_defeats[location_name] then
        set_stage_state_cleared(boss_defeats[location_name])
    end

    -- Break Man -> unlock Wily Fortress
    if location_name == "Break Man" then
        local bm = Tracker:FindObjectForCode("break_man_state")
        if bm then bm.CurrentStage = 1 end
        local wf = Tracker:FindObjectForCode("wily_fortress_state")
        if wf and wf.CurrentStage == 0 then wf.CurrentStage = 1 end
    end

    -- Wily stage boss clears
    local wily_clears = {
        ["Wily 1 Boss"] = "wily_1_cleared",
        ["Wily 2 Boss"] = "wily_2_cleared",
        ["Wily 3 Boss"] = "wily_3_cleared",
        ["Wily 4 Boss"] = "wily_4_cleared",
        ["Wily 5 Boss"] = "wily_5_cleared",
    }
    if wily_clears[location_name] then
        local item = Tracker:FindObjectForCode(wily_clears[location_name])
        if item then item.Active = true end
    end

    -- Doc Robot stage progression (each boss defeat advances stage 0->1->2)
    local doc_stage_bosses = {
        ["Doc Robot Needle Man - Air Man Boss"]   = "stage_doc_needle",
        ["Doc Robot Needle Man - Crash Man Boss"] = "stage_doc_needle",
        ["Doc Robot Gemini Man - Bubble Man Boss"] = "stage_doc_gemini",
        ["Doc Robot Gemini Man - Flash Man Boss"]  = "stage_doc_gemini",
        ["Doc Robot Spark Man - Metal Man Boss"]   = "stage_doc_spark",
        ["Doc Robot Spark Man - Quick Man Boss"]   = "stage_doc_spark",
        ["Doc Robot Shadow Man - Heat Man Boss"]   = "stage_doc_shadow",
        ["Doc Robot Shadow Man - Wood Man Boss"]   = "stage_doc_shadow",
    }
    if doc_stage_bosses[location_name] then
        local item = Tracker:FindObjectForCode(doc_stage_bosses[location_name])
        if item and item.CurrentStage < 2 then
            item.CurrentStage = item.CurrentStage + 1
        end
    end

    -- ---------------------------------------------------------------
    -- Section check: mark the map location section as collected
    -- ---------------------------------------------------------------
    local section_path = LOCATION_NAME_TO_SECTION[location_name]
    if section_path then
        check_section(section_path)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("[MM3 AP] Checked: %s -> %s", location_name, section_path))
        end
    else
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("[MM3 AP] No section mapping for location: %s", location_name))
        end
    end
end

Archipelago:AddClearHandler("clear handler", onClear)
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    Archipelago:AddItemHandler("item handler", onItem)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    Archipelago:AddLocationHandler("location handler", onLocation)
end

print("[MM3 AP] Autotracking registered.")
