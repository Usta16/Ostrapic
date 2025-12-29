--[[
    Ostrapic UI - Input Component
]]

local Input = {}
Input.__index = Input

function Input.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Input)
    
    self.Value = config.Default or config.Value or ""
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local AddCorner = Utility.AddCorner
    
    local hasDesc = config.Desc ~= nil
    
    -- Container
    local container = Create("Frame", {
        Name = "Input",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, hasDesc and 72 or 58),
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Input",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -28, 0, 18),
        Parent = container
    })
    
    -- Description
    if hasDesc then
        Create("TextLabel", {
            Name = "Desc",
            Text = config.Desc,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextColor3 = Theme.TextDark,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 14, 0, 24),
            Size = UDim2.new(1, -28, 0, 14),
            Parent = container
        })
    end
    
    -- TextBox
    local textBox = Create("TextBox", {
        Name = "Box",
        BackgroundColor3 = Theme.CardLight,
        Position = UDim2.new(0, 14, 1, -30),
        Size = UDim2.new(1, -28, 0, 24),
        Text = self.Value,
        PlaceholderText = config.Placeholder or "Type here...",
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.TextDark,
        ClearTextOnFocus = false,
        Parent = container
    })
    AddCorner(textBox, UDim.new(0, 6))
    self.TextBox = textBox
    
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Parent = textBox
    })
    
    -- Focus lost handler
    textBox.FocusLost:Connect(function()
        self.Value = textBox.Text
        self.Callback(self.Value)
    end)
    
    -- Methods
    function self:Set(value)
        self.Value = value
        textBox.Text = value
    end
    
    function self:Get()
        return self.Value
    end
    
    return self
end

return Input
