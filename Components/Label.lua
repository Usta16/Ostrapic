--[[
    Ostrapic UI - Label Component
]]

local Label = {}

function Label.new(Tab, config)
    config = config or {}
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    
    local label = Create("TextLabel", {
        Name = "Label",
        Text = config.Text or "Label",
        Font = Enum.Font.Gotham,
        TextSize = config.TextSize or 13,
        TextColor3 = config.Color or Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 22),
        Parent = Tab.Content
    })
    
    local self = {}
    
    function self:Set(text)
        label.Text = text
    end
    
    function self:Get()
        return label.Text
    end
    
    return self
end

return Label
