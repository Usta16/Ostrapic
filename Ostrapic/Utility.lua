--[[
    Ostrapic UI - Utility Module
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Utility = {}

function Utility.Create(className, properties)
    local instance = Instance.new(className)
    local parent = nil
    
    for key, value in pairs(properties or {}) do
        if key == "Parent" then
            parent = value
        else
            instance[key] = value
        end
    end
    
    if parent then
        instance.Parent = parent
    end
    
    return instance
end

function Utility.Tween(object, properties, duration)
    if not object or typeof(object) ~= "Instance" then 
        return nil 
    end
    
    local tweenInfo = TweenInfo.new(
        duration or 0.2, 
        Enum.EasingStyle.Quart, 
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function Utility.AddCorner(parent, radius)
    return Utility.Create("UICorner", {
        CornerRadius = radius or UDim.new(0, 8),
        Parent = parent
    })
end

function Utility.AddStroke(parent, color, thickness, transparency)
    return Utility.Create("UIStroke", {
        Color = color or Color3.fromRGB(45, 45, 55),
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
        Parent = parent
    })
end

function Utility.AddPadding(parent, top, bottom, left, right)
    return Utility.Create("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        Parent = parent
    })
end

function Utility.AddListLayout(parent, padding, direction)
    return Utility.Create("UIListLayout", {
        Padding = UDim.new(0, padding or 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = direction or Enum.FillDirection.Vertical,
        Parent = parent
    })
end

function Utility.CreateIcon(parent, iconId, size, color)
    local icon = Utility.Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, size or 16, 0, size or 16),
        Image = iconId or "",
        ImageColor3 = color or Color3.fromRGB(255, 255, 255),
        ScaleType = Enum.ScaleType.Fit,
        Parent = parent
    })
    return icon
end

function Utility.MakeDraggable(frame, handle)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

return Utility
