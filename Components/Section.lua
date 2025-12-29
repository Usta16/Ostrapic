--[[
    Ostrapic UI - Section Component
]]

local Section = {}

function Section.new(Tab, config)
    config = config or {}
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    
    local section = Create("Frame", {
        Name = "Section",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 28),
        Parent = Tab.Content
    })
    
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Section",
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Theme.Primary,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 4, 0, 8),
        Size = UDim2.new(1, -8, 0, 16),
        Parent = section
    })
    
    return section
end

return Section
