--[[
    Ostrapic UI - Icon System
    Lucide-style icons using Asset IDs
]]

local Icons = {}

-- Default Lucide-style icons (you can add more)
Icons.List = {
    -- Navigation
    ["home"] = "rbxassetid://7733960981",
    ["settings"] = "rbxassetid://7734053495",
    ["menu"] = "rbxassetid://7734010953",
    ["search"] = "rbxassetid://7734052478",
    ["arrow-left"] = "rbxassetid://7733714927",
    ["arrow-right"] = "rbxassetid://7733715669",
    ["arrow-up"] = "rbxassetid://7733716641",
    ["arrow-down"] = "rbxassetid://7733714188",
    ["chevron-down"] = "rbxassetid://7733746897",
    ["chevron-up"] = "rbxassetid://7733748096",
    ["chevron-left"] = "rbxassetid://7733747413",
    ["chevron-right"] = "rbxassetid://7733747774",
    ["x"] = "rbxassetid://7734118086",
    ["check"] = "rbxassetid://7733746367",
    ["plus"] = "rbxassetid://7734038473",
    ["minus"] = "rbxassetid://7734011577",
    
    -- Actions
    ["play"] = "rbxassetid://7734036443",
    ["pause"] = "rbxassetid://7734028657",
    ["stop"] = "rbxassetid://7734057498",
    ["refresh"] = "rbxassetid://7734042453",
    ["download"] = "rbxassetid://7733770145",
    ["upload"] = "rbxassetid://7734107680",
    ["copy"] = "rbxassetid://7733756052",
    ["trash"] = "rbxassetid://7734103748",
    ["edit"] = "rbxassetid://7733777498",
    ["save"] = "rbxassetid://7734047498",
    ["external-link"] = "rbxassetid://7733789270",
    
    -- User
    ["user"] = "rbxassetid://7734109580",
    ["users"] = "rbxassetid://7734110380",
    ["user-plus"] = "rbxassetid://7734109954",
    ["user-minus"] = "rbxassetid://7734109768",
    
    -- Objects
    ["star"] = "rbxassetid://7734055498",
    ["heart"] = "rbxassetid://7733851286",
    ["flag"] = "rbxassetid://7733803921",
    ["bookmark"] = "rbxassetid://7733738029",
    ["bell"] = "rbxassetid://7733736314",
    ["lock"] = "rbxassetid://7733976aborr3",
    ["unlock"] = "rbxassetid://7734107306",
    ["key"] = "rbxassetid://7733899498",
    ["shield"] = "rbxassetid://7734052874",
    ["eye"] = "rbxassetid://7733793275",
    ["eye-off"] = "rbxassetid://7733793660",
    
    -- Gaming
    ["gamepad"] = "rbxassetid://7733817858",
    ["target"] = "rbxassetid://7734074637",
    ["crosshair"] = "rbxassetid://7733758884",
    ["swords"] = "rbxassetid://7734068297",
    ["zap"] = "rbxassetid://7734121086",
    ["flame"] = "rbxassetid://7733803623",
    ["droplet"] = "rbxassetid://7733771637",
    
    -- Interface
    ["sliders"] = "rbxassetid://7734054581",
    ["toggle-left"] = "rbxassetid://7734093584",
    ["toggle-right"] = "rbxassetid://7734093897",
    ["circle"] = "rbxassetid://7733749953",
    ["square"] = "rbxassetid://7734054895",
    ["box"] = "rbxassetid://7733739430",
    ["layers"] = "rbxassetid://7733906898",
    ["layout"] = "rbxassetid://7733908258",
    ["grid"] = "rbxassetid://7733840098",
    ["list"] = "rbxassetid://7733963870",
    
    -- Communication
    ["message-circle"] = "rbxassetid://7734009498",
    ["message-square"] = "rbxassetid://7734009874",
    ["mail"] = "rbxassetid://7733987652",
    ["send"] = "rbxassetid://7734050498",
    ["phone"] = "rbxassetid://7734032498",
    
    -- Files
    ["file"] = "rbxassetid://7733798498",
    ["file-text"] = "rbxassetid://7733801498",
    ["folder"] = "rbxassetid://7733808498",
    ["folder-open"] = "rbxassetid://7733808874",
    ["image"] = "rbxassetid://7733868498",
    ["video"] = "rbxassetid://7734114498",
    ["music"] = "rbxassetid://7734015498",
    
    -- Misc
    ["info"] = "rbxassetid://7733876498",
    ["alert-circle"] = "rbxassetid://7733703498",
    ["alert-triangle"] = "rbxassetid://7733704498",
    ["help-circle"] = "rbxassetid://7733852498",
    ["terminal"] = "rbxassetid://7734081498",
    ["code"] = "rbxassetid://7733752498",
    ["command"] = "rbxassetid://7733754498",
    ["cpu"] = "rbxassetid://7733757498",
    ["database"] = "rbxassetid://7733764498",
    ["globe"] = "rbxassetid://7733834498",
    ["wifi"] = "rbxassetid://7734116498",
    ["bluetooth"] = "rbxassetid://7733737498",
    ["battery"] = "rbxassetid://7733734498",
    ["power"] = "rbxassetid://7734039498",
    ["moon"] = "rbxassetid://7734012498",
    ["sun"] = "rbxassetid://7734062498",
    ["cloud"] = "rbxassetid://7733751498",
    ["compass"] = "rbxassetid://7733754874",
    ["map"] = "rbxassetid://7733993498",
    ["navigation"] = "rbxassetid://7734017498",
    
    -- Default/Fallback
    ["default"] = "rbxassetid://7733770145",
    ["none"] = "",
}

-- Get icon by name or asset ID
function Icons.Get(name)
    if not name or name == "" then
        return ""
    end
    
    -- If it's already an asset ID, return it
    if string.match(name, "^rbxassetid://") then
        return name
    end
    
    -- If it's a number (asset ID without prefix)
    if tonumber(name) then
        return "rbxassetid://" .. name
    end
    
    -- Look up in icon list
    local icon = Icons.List[string.lower(name)]
    if icon then
        return icon
    end
    
    -- Return default if not found
    return Icons.List["default"]
end

-- Add custom icons
function Icons.Add(name, assetId)
    if string.match(assetId, "^rbxassetid://") then
        Icons.List[string.lower(name)] = assetId
    else
        Icons.List[string.lower(name)] = "rbxassetid://" .. assetId
    end
end

-- Add multiple icons at once
function Icons.AddBulk(iconTable)
    for name, assetId in pairs(iconTable) do
        Icons.Add(name, assetId)
    end
end

return Icons
