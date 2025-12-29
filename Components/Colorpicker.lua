--[[
    Ostrapic UI - Colorpicker Component
]]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Colorpicker = {}
Colorpicker.__index = Colorpicker

function Colorpicker.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Colorpicker)
    
    self.Value = config.Default or config.Value or Color3.fromRGB(255, 255, 255)
    self.Open = false
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    local AddStroke = Utility.AddStroke
    
    local Mouse = Players.LocalPlayer:GetMouse()
    
    -- Container
    local container = Create("Frame", {
        Name = "Colorpicker",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, 44),
        ClipsDescendants = true,
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Color",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0.6, 0, 0, 44),
        Parent = container
    })
    
    -- Preview
    local preview = Create("Frame", {
        Name = "Preview",
        BackgroundColor3 = self.Value,
        Position = UDim2.new(1, -50, 0.5, -11),
        Size = UDim2.new(0, 36, 0, 22),
        Parent = container
    })
    AddCorner(preview, UDim.new(0, 6))
    AddStroke(preview, Theme.Border, 1, 0)
    self.Preview = preview
    
    -- Picker area
    local picker = Create("Frame", {
        Name = "Picker",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 50),
        Size = UDim2.new(1, -28, 0, 110),
        Parent = container
    })
    
    -- Saturation/Value square
    local satVal = Create("Frame", {
        Name = "SatVal",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        Size = UDim2.new(1, 0, 0, 80),
        Parent = picker
    })
    AddCorner(satVal, UDim.new(0, 8))
    self.SatVal = satVal
    
    -- White gradient (saturation)
    Create("UIGradient", {
        Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1)),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Parent = satVal
    })
    
    -- Black gradient (value)
    local dark = Create("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        Parent = satVal
    })
    AddCorner(dark, UDim.new(0, 8))
    
    Create("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Parent = dark
    })
    
    -- Hue bar
    local hueBar = Create("Frame", {
        Name = "HueBar",
        Position = UDim2.new(0, 0, 0, 88),
        Size = UDim2.new(1, 0, 0, 18),
        Parent = picker
    })
    AddCorner(hueBar, UDim.new(0, 6))
    self.HueBar = hueBar
    
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        }),
        Parent = hueBar
    })
    
    -- HSV values
    local h, s, v = Color3.toHSV(self.Value)
    
    local function UpdateColor()
        self.Value = Color3.fromHSV(h, s, v)
        preview.BackgroundColor3 = self.Value
        satVal.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        self.Callback(self.Value)
    end
    
    -- SatVal interaction
    local satButton = Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Parent = satVal
    })
    
    satButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local dragging = true
            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not dragging then 
                    conn:Disconnect() 
                    return 
                end
                s = math.clamp((Mouse.X - satVal.AbsolutePosition.X) / satVal.AbsoluteSize.X, 0, 1)
                v = math.clamp(1 - (Mouse.Y - satVal.AbsolutePosition.Y) / satVal.AbsoluteSize.Y, 0, 1)
                UpdateColor()
            end)
            
            local endConn
            endConn = UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    endConn:Disconnect()
                end
            end)
        end
    end)
    
    -- Hue interaction
    local hueButton = Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Parent = hueBar
    })
    
    hueButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local dragging = true
            local conn
            conn = RunService.RenderStepped:Connect(function()
                if not dragging then 
                    conn:Disconnect() 
                    return 
                end
                h = math.clamp((Mouse.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
                UpdateColor()
            end)
            
            local endConn
            endConn = UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    endConn:Disconnect()
                end
            end)
        end
    end)
    
    -- Header click to toggle
    local header = Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 44),
        Text = "",
        Parent = container
    })
    
    header.MouseButton1Click:Connect(function()
        self.Open = not self.Open
        Tween(container, {Size = UDim2.new(1, 0, 0, self.Open and 170 or 44)}, 0.25)
    end)
    
    -- Methods
    function self:Set(color)
        self.Value = color
        preview.BackgroundColor3 = color
        h, s, v = Color3.toHSV(color)
        satVal.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
    end
    
    function self:Get()
        return self.Value
    end
    
    return self
end

return Colorpicker
