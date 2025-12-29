--[[
    Ostrapic UI - Keybind Component
]]

local UserInputService = game:GetService("UserInputService")

local Keybind = {}
Keybind.__index = Keybind

function Keybind.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Keybind)
    
    self.Value = config.Default or config.Value or "None"
    self.Listening = false
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local AddCorner = Utility.AddCorner
    
    -- Container
    local container = Create("Frame", {
        Name = "Keybind",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, 44),
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Keybind",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0.6, 0, 1, 0),
        Parent = container
    })
    
    -- Key button
    local keyButton = Create("TextButton", {
        Name = "KeyButton",
        BackgroundColor3 = Theme.CardLight,
        Position = UDim2.new(1, -80, 0.5, -13),
        Size = UDim2.new(0, 66, 0, 26),
        Text = self.Value,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextColor3 = Theme.Text,
        Parent = container
    })
    AddCorner(keyButton, UDim.new(0, 6))
    self.KeyButton = keyButton
    
    -- Click to listen
    keyButton.MouseButton1Click:Connect(function()
        self.Listening = true
        keyButton.Text = "..."
    end)
    
    -- Input listener
    UserInputService.InputBegan:Connect(function(input, processed)
        if self.Listening and input.UserInputType == Enum.UserInputType.Keyboard then
            self.Value = input.KeyCode.Name
            keyButton.Text = self.Value
            self.Listening = false
            self.Callback(self.Value)
        end
    end)
    
    -- Methods
    function self:Set(value)
        self.Value = value
        keyButton.Text = value
    end
    
    function self:Get()
        return self.Value
    end
    
    return self
end

return Keybind
