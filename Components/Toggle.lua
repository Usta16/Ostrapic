--[[
    Ostrapic UI - Toggle Component
]]

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Toggle)
    
    self.Value = config.Default or config.Value or false
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    
    local hasDesc = config.Desc ~= nil
    
    local container = Create("Frame", {
        Name = "Toggle",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, hasDesc and 52 or 40),
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Toggle",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, hasDesc and 8 or 0),
        Size = UDim2.new(1, -70, 0, hasDesc and 20 or 40),
        Parent = container
    })
    
    if hasDesc then
        Create("TextLabel", {
            Name = "Desc",
            Text = config.Desc,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextColor3 = Theme.TextDark,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 14, 0, 28),
            Size = UDim2.new(1, -70, 0, 16),
            Parent = container
        })
    end
    
    local switch = Create("Frame", {
        Name = "Switch",
        BackgroundColor3 = self.Value and Theme.Primary or Theme.CardLight,
        Position = UDim2.new(1, -56, 0.5, -11),
        Size = UDim2.new(0, 42, 0, 22),
        Parent = container
    })
    AddCorner(switch, UDim.new(1, 0))
    self.Switch = switch
    
    local knob = Create("Frame", {
        Name = "Knob",
        BackgroundColor3 = Theme.Text,
        Position = self.Value and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        Parent = switch
    })
    AddCorner(knob, UDim.new(1, 0))
    self.Knob = knob
    
    local function UpdateVisual()
        Tween(switch, {BackgroundColor3 = self.Value and Theme.Primary or Theme.CardLight}, 0.2)
        Tween(knob, {Position = self.Value and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}, 0.2)
    end
    
    local clickButton = Create("TextButton", {
        Name = "ClickArea",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Parent = container
    })
    
    clickButton.MouseButton1Click:Connect(function()
        self.Value = not self.Value
        UpdateVisual()
        self.Callback(self.Value)
    end)
    
    if self.Value then
        self.Callback(self.Value)
    end
    
    function self:Set(value)
        if self.Value ~= value then
            self.Value = value
            UpdateVisual()
            self.Callback(self.Value)
        end
    end
    
    function self:Get()
        return self.Value
    end
    
    return self
end

return Toggle
