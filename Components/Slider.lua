--[[
    Ostrapic UI - Slider Component (Thin Line Style)
]]

local UserInputService = game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

function Slider.new(Tab, config)
    config = config or {}
    local valueConfig = config.Value or {}
    
    local self = setmetatable({}, Slider)
    
    self.Value = valueConfig.Default or valueConfig.Min or 0
    self.Min = valueConfig.Min or 0
    self.Max = valueConfig.Max or 100
    self.Step = config.Step or 1
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    
    local hasDesc = config.Desc ~= nil
    
    -- Container
    local container = Create("Frame", {
        Name = "Slider",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, hasDesc and 70 or 55),
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    -- Title row
    local titleRow = Create("Frame", {
        Name = "TitleRow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 10),
        Size = UDim2.new(1, -28, 0, 18),
        Parent = container
    })
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Slider",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.7, 0, 1, 0),
        Parent = titleRow
    })
    
    -- Value display
    local valueLabel = Create("TextLabel", {
        Name = "Value",
        Text = tostring(self.Value),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.Primary,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.7, 0, 0, 0),
        Size = UDim2.new(0.3, 0, 1, 0),
        Parent = titleRow
    })
    self.ValueLabel = valueLabel
    
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
            Position = UDim2.new(0, 14, 0, 28),
            Size = UDim2.new(1, -28, 0, 14),
            Parent = container
        })
    end
    
    -- Slider track (thin line)
    local track = Create("Frame", {
        Name = "Track",
        BackgroundColor3 = Theme.CardLight,
        Position = UDim2.new(0, 14, 1, -20),
        Size = UDim2.new(1, -28, 0, 4),
        Parent = container
    })
    AddCorner(track, UDim.new(1, 0))
    self.Track = track
    
    -- Filled portion
    local initialFill = (self.Value - self.Min) / (self.Max - self.Min)
    local fill = Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = Theme.Primary,
        Size = UDim2.new(initialFill, 0, 1, 0),
        Parent = track
    })
    AddCorner(fill, UDim.new(1, 0))
    self.Fill = fill
    
    -- Knob (circle)
    local knob = Create("Frame", {
        Name = "Knob",
        BackgroundColor3 = Theme.Primary,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(initialFill, 0, 0.5, 0),
        Size = UDim2.new(0, 14, 0, 14),
        ZIndex = 2,
        Parent = track
    })
    AddCorner(knob, UDim.new(1, 0))
    self.Knob = knob
    
    -- Knob inner dot
    local knobInner = Create("Frame", {
        Name = "Inner",
        BackgroundColor3 = Theme.Text,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 6, 0, 6),
        Parent = knob
    })
    AddCorner(knobInner, UDim.new(1, 0))
    
    -- Dragging logic
    local dragging = false
    
    local function UpdateSlider(inputX)
        local pos = math.clamp((inputX - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local rawValue = self.Min + (self.Max - self.Min) * pos
        local stepped = math.floor(rawValue / self.Step + 0.5) * self.Step
        stepped = math.clamp(stepped, self.Min, self.Max)
        
        if stepped ~= self.Value then
            self.Value = stepped
            local norm = (self.Value - self.Min) / (self.Max - self.Min)
            fill.Size = UDim2.new(norm, 0, 1, 0)
            knob.Position = UDim2.new(norm, 0, 0.5, 0)
            valueLabel.Text = tostring(self.Value)
            self.Callback(self.Value)
        end
    end
    
    -- Click/drag detection
    local clickButton = Create("TextButton", {
        Name = "ClickArea",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, -8),
        Size = UDim2.new(1, 0, 1, 16),
        Text = "",
        ZIndex = 3,
        Parent = track
    })
    
    clickButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            -- Grow knob on press
            Tween(knob, {Size = UDim2.new(0, 18, 0, 18)}, 0.1)
            UpdateSlider(input.Position.X)
        end
    end)
    
    clickButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            -- Shrink knob on release
            Tween(knob, {Size = UDim2.new(0, 14, 0, 14)}, 0.1)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input.Position.X)
        end
    end)
    
    -- Methods
    function self:Set(value)
        self.Value = math.clamp(value, self.Min, self.Max)
        local norm = (self.Value - self.Min) / (self.Max - self.Min)
        fill.Size = UDim2.new(norm, 0, 1, 0)
        knob.Position = UDim2.new(norm, 0, 0.5, 0)
        valueLabel.Text = tostring(self.Value)
        self.Callback(self.Value)
    end
    
    function self:Get()
        return self.Value
    end
    
    return self
end

return Slider
