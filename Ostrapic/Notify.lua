--[[
    Ostrapic UI - Notification Module
]]

local Players = game:GetService("Players")

local Notify = {}

function Notify.new(Ostrapic, config)
    config = config or {}
    
    local Utility = Ostrapic.Utility
    local Theme = Ostrapic.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    
    local screenGui = PlayerGui:FindFirstChild("OstrapicNotify")
    if not screenGui then
        screenGui = Create("ScreenGui", {
            Name = "OstrapicNotify",
            ResetOnSpawn = false,
            Parent = PlayerGui
        })
        
        local container = Create("Frame", {
            Name = "Container",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -310, 0, 10),
            Size = UDim2.new(0, 300, 1, -20),
            Parent = screenGui
        })
        
        Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Parent = container
        })
    end
    
    local container = screenGui.Container
    
    local typeColors = {
        Info = Theme.Primary,
        Success = Theme.Success,
        Warning = Theme.Warning,
        Error = Theme.Error
    }
    
    local accentColor = typeColors[config.Type] or Theme.Primary
    
    local notification = Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, 65),
        Position = UDim2.new(1, 20, 0, 0),
        Parent = container
    })
    AddCorner(notification, UDim.new(0, 10))
    
    Create("UIStroke", {
        Color = accentColor,
        Thickness = 1,
        Transparency = 0.3,
        Parent = notification
    })
    
    local accent = Create("Frame", {
        Name = "Accent",
        BackgroundColor3 = accentColor,
        Size = UDim2.new(0, 3, 0.7, 0),
        Position = UDim2.new(0, 8, 0.15, 0),
        Parent = notification
    })
    AddCorner(accent, UDim.new(0, 2))
    
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Notification",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 12),
        Size = UDim2.new(1, -30, 0, 18),
        Parent = notification
    })
    
    Create("TextLabel", {
        Name = "Content",
        Text = config.Content or "",
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 20, 0, 32),
        Size = UDim2.new(1, -30, 0, 25),
        Parent = notification
    })
    
    Tween(notification, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
    
    task.delay(config.Duration or 4, function()
        Tween(notification, {Position = UDim2.new(1, 20, 0, 0)}, 0.3)
        task.wait(0.35)
        if notification and notification.Parent then
            notification:Destroy()
        end
    end)
    
    return notification
end

return Notify
