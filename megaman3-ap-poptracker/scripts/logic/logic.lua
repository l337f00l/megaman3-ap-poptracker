-- logic.lua
-- Mega Man 3 AP - access rules

-- Doc Robot stages require all 8 Robot Master stage access items
-- In the AP world, the Doc Robot stage access items are separate items
-- so this logic just ensures the stage access items are checked

-- Helper: check if all 8 Robot Master stages have been accessed
function all_robot_masters_beaten()
    local stages = {
        "stage_needle_man", "stage_magnet_man", "stage_gemini_man",
        "stage_hard_man",   "stage_top_man",    "stage_snake_man",
        "stage_spark_man",  "stage_shadow_man"
    }
    for _, code in ipairs(stages) do
        local obj = Tracker:FindObjectForCode(code)
        if not obj or not obj.Active then
            return false
        end
    end
    return true
end

-- Doc Robot stages additionally require their own stage access items
-- stage_doc_needle, stage_doc_magnet, stage_doc_gemini, stage_doc_hard
-- These are tracked separately in the AP world

-- Wily stages require the Wily stage access item
-- stage_wily is tracked as a single toggle item

print("[MM3] Logic loaded.")
