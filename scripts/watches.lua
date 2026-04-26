-- State sync via location section changes
-- Boss portraits: stage 0=locked, stage 1=accessible (access code), stage 2=defeated (X)
-- Break Man: defeat advances break_man_state to stage 1 (unlocks Wily stages)
-- Doc Robot stages: stage 0=locked, stage 1=accessible (access code received via item_mapping)
--   stage 2 is NOT auto-advanced - clearing both sub-bosses in game = stage complete
--   but AP has no separate 'stage cleared' event, so we don't auto-advance
--   Users can manually click the doc stage icon to mark as complete if desired

local BOSS_DEFEAT_TO_STATE = {
    ["Needle Man/Defeated"]   = "needle_man_state",
    ["Magnet Man/Defeated"]   = "magnet_man_state",
    ["Gemini Man/Defeated"]   = "gemini_man_state",
    ["Hard Man/Defeated"]     = "hard_man_state",
    ["Top Man/Defeated"]      = "top_man_state",
    ["Snake Man/Defeated"]    = "snake_man_state",
    ["Spark Man/Defeated"]    = "spark_man_state",
    ["Shadow Man/Defeated"]   = "shadow_man_state",
}

local function advanceToStage(item_code, target_stage)
    local obj = Tracker:FindObjectForCode(item_code)
    if obj and obj.CurrentStage < target_stage then
        obj.CurrentStage = target_stage
    end
end

ScriptHost:AddOnLocationSectionChangedHandler("state_sync_handler", function(location)
    if location.AvailableChestCount ~= 0 then return end

    local path = location.FullID
    if path:sub(1,1) == "/" then path = path:sub(2) end

    -- Boss defeat -> portrait to stage 2 (X)
    local boss_state = BOSS_DEFEAT_TO_STATE[path]
    if boss_state then
        advanceToStage(boss_state, 2)
        return
    end

    -- Break Man defeat -> unlock Wily stages
    if path == "Break Man/Defeated" then
        advanceToStage("break_man_state", 1)
        return
    end
end)

-- Doc Robot stage defeat tracking
-- Correct pairings: Needle=(Air+Crash), Gemini=(Flash+Bubble), Shadow=(Wood+Heat), Spark=(Metal+Quick)
local DOC_BOSS_TO_STAGE = {
    ["Doc Robot (Air)/Defeated"]    = "stage_doc_needle",
    ["Doc Robot (Crash)/Defeated"]  = "stage_doc_needle",
    ["Doc Robot (Flash)/Defeated"]  = "stage_doc_gemini",
    ["Doc Robot (Bubble)/Defeated"] = "stage_doc_gemini",
    ["Doc Robot (Wood)/Defeated"]   = "stage_doc_shadow",
    ["Doc Robot (Heat)/Defeated"]   = "stage_doc_shadow",
    ["Doc Robot (Metal)/Defeated"]  = "stage_doc_spark",
    ["Doc Robot (Quick)/Defeated"]  = "stage_doc_spark",
}

ScriptHost:AddOnLocationSectionChangedHandler("doc_stage_sync", function(location)
    if location.AvailableChestCount ~= 0 then return end

    local path = location.FullID
    if path:sub(1,1) == "/" then path = path:sub(2) end

    local doc_state = DOC_BOSS_TO_STAGE[path]
    if doc_state then
        local obj = Tracker:FindObjectForCode(doc_state)
        if obj then
            local cleared = 0
            for p, code in pairs(DOC_BOSS_TO_STAGE) do
                if code == doc_state then
                    local loc = Tracker:FindObjectForCode("@" .. p)
                    if loc then
                        local sec = loc
                        local ok, val = pcall(function() return loc.AvailableChestCount end)
                        if not (ok and val ~= nil) then
                            local ok2, secs = pcall(function() return loc.Sections end)
                            if ok2 and secs ~= nil and secs[1] ~= nil then sec = secs[1] end
                        end
                        if sec and sec.AvailableChestCount ~= nil and sec.AvailableChestCount == 0 then
                            cleared = cleared + 1
                        end
                    end
                end
            end
            if cleared >= 2 then
                obj.CurrentStage = 2
            end
        end
    end
end)

-- Wily stage boss defeat tracking
-- Advances toggle items used as gates for sequential Wily stage unlocking
local WILY_BOSS_TO_CODE = {
    ["Kamegoro Maker/Defeated"]    = "kamegoro_defeated",
    ["Yellow Devil MK-II/Defeated"] = "yellow_devil_defeated",
    ["Holograph Mega Man/Defeated"] = "holograph_defeated",
    ["Wily Machine 3/Defeated"]    = "wily_machine_defeated",
}

ScriptHost:AddOnLocationSectionChangedHandler("wily_boss_sync", function(location)
    if location.AvailableChestCount ~= 0 then return end

    local path = location.FullID
    if path:sub(1,1) == "/" then path = path:sub(2) end

    local code = WILY_BOSS_TO_CODE[path]
    if code then
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            obj.Active = true
        end
    end
end)

-- Load-time sync: corrects boss portrait stages and doc stage states
-- based on the current location section states (from autosave).
-- Runs once at pack load so Reload Pack shows correct item states.
function syncStatesFromLocations()
    -- Sync robot master portraits
    local function syncBoss(location_path, item_code)
        local obj = Tracker:FindObjectForCode("@" .. location_path)
        if obj then
            local sec = obj
            local ok, val = pcall(function() return obj.AvailableChestCount end)
            if not (ok and val ~= nil) then
                local ok2, secs = pcall(function() return obj.Sections end)
                if ok2 and secs and secs[1] then sec = secs[1] end
            end
            if sec and sec.AvailableChestCount ~= nil and sec.AvailableChestCount == 0 then
                advanceToStage(item_code, 2)
            end
        end
    end

    -- Robot master portraits
    for path, code in pairs(BOSS_DEFEAT_TO_STATE) do
        syncBoss(path, code)
    end

    -- Break Man
    local bm = Tracker:FindObjectForCode("@Break Man/Defeated")
    if bm then
        local sec = bm
        local ok, val = pcall(function() return bm.AvailableChestCount end)
        if not (ok and val ~= nil) then
            local ok2, secs = pcall(function() return bm.Sections end)
            if ok2 and secs and secs[1] then sec = secs[1] end
        end
        if sec and sec.AvailableChestCount ~= nil and sec.AvailableChestCount == 0 then
            advanceToStage("break_man_state", 1)
        end
    end

    -- Doc stage portraits: sync to stage 2 if both sub-bosses cleared
    for path, doc_state in pairs(DOC_BOSS_TO_STAGE) do
        local loc = Tracker:FindObjectForCode("@" .. path)
        if loc then
            local sec = loc
            local ok, val = pcall(function() return loc.AvailableChestCount end)
            if not (ok and val ~= nil) then
                local ok2, secs = pcall(function() return loc.Sections end)
                if ok2 and secs and secs[1] then sec = secs[1] end
            end
            if sec and sec.AvailableChestCount ~= nil and sec.AvailableChestCount == 0 then
                -- Count both sub-bosses for this doc stage
                local cleared = 0
                for p, code in pairs(DOC_BOSS_TO_STAGE) do
                    if code == doc_state then
                        local l2 = Tracker:FindObjectForCode("@" .. p)
                        if l2 then
                            local s2 = l2
                            local ok3, v3 = pcall(function() return l2.AvailableChestCount end)
                            if not (ok3 and v3 ~= nil) then
                                local ok4, secs4 = pcall(function() return l2.Sections end)
                                if ok4 and secs4 and secs4[1] then s2 = secs4[1] end
                            end
                            if s2 and s2.AvailableChestCount ~= nil and s2.AvailableChestCount == 0 then
                                cleared = cleared + 1
                            end
                        end
                    end
                end
                if cleared >= 2 then
                    local obj = Tracker:FindObjectForCode(doc_state)
                    if obj then obj.CurrentStage = 2 end
                end
            end
        end
    end

    -- Wily boss toggles
    for path, code in pairs(WILY_BOSS_TO_CODE) do
        local loc = Tracker:FindObjectForCode("@" .. path)
        if loc then
            local sec = loc
            local ok, val = pcall(function() return loc.AvailableChestCount end)
            if not (ok and val ~= nil) then
                local ok2, secs = pcall(function() return loc.Sections end)
                if ok2 and secs and secs[1] then sec = secs[1] end
            end
            if sec and sec.AvailableChestCount ~= nil and sec.AvailableChestCount == 0 then
                local obj = Tracker:FindObjectForCode(code)
                if obj then obj.Active = true end
            end
        end
    end
end

-- Run sync after a brief delay to ensure autosave is fully restored
local _sync_done = false
local _sync_frames = 0
ScriptHost:AddOnFrameHandler("load_time_sync", function()
    if _sync_done then return end
    _sync_frames = _sync_frames + 1
    if _sync_frames < 5 then return end  -- wait a few frames for autosave to load
    _sync_done = true
    ScriptHost:RemoveOnFrameHandler("load_time_sync")
    syncStatesFromLocations()
end)
