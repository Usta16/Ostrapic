--[[
    Ostrapic UI - Window Module
]]

local Players = game:GetService("Players")

local Window = {}
Window.__index = Window

function Window.new(Ostrapic, config)
    config = config or {}
    
    local self = setmetatable({}, Window)
    
    self.Ostrapic = Ostrapic
    self.Theme = Ostrapic.Theme
    self.Utility = Ostrapic.Utility
    self.Components = Ostrapic.Components
    self.Tabs = {}
    self.CurrentTab = nil
    self.Minimized = false
    
    local Create = self.Utility.Create
    local Tween = self.Utility.Tween
    local AddCorner = self.Utility.AddCorner
    local AddStroke = self.Utility.AddStroke
    local MakeDraggable = self.Utility.MakeDraggable
    local Theme = self.Theme
    
    local Player = Players.LocalPlayer
    
    -- Create ScreenGui
    local screenGui = Create("ScreenGui", {
        Name = "OstrapicUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Try CoreGui first, fallback to PlayerGui
    local success = pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not success then
        screenGui.Parent = Player:WaitForChild("PlayerGui")
    end
    
    self.ScreenGui = screenGui
    
    -- Main Frame
    local main = Create("Frame", {
        Name = "Main",
        BackgroundColor3 = Theme.Background,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 400),
        Parent = screenGui
    })
    AddCorner(main, UDim.new(0, 12))
    AddStroke(main, Theme.Border, 1, 0.3)
    self.Main = main
    
    -- Shadow
    Create("ImageLabel", {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -20, 0, -20),
        Size = UDim2.new(1, 40, 1, 40),
        ZIndex = -1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.4,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = main
    })
    
    -- Topbar
    local topbar = Create("Frame", {
        Name = "Topbar",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = main
    })
    AddCorner(topbar, UDim.new(0, 12))
    
    -- Fix bottom corners
    Create("Frame", {
        Name = "TopbarFix",
        BackgroundColor3 = Theme.Card,
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BorderSizePixel = 0,
        Parent = topbar
    })
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Ostrapic UI",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 18, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Parent = topbar
    })
    
    -- Make draggable
    MakeDraggable(main, topbar)
    
    -- Window buttons container
    local buttonContainer = Create("Frame", {
        Name = "Buttons",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -80, 0.5, -8),
        Size = UDim2.new(0, 65, 0, 16),
        Parent = topbar
    })
    
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 10),
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = buttonContainer
    })
    
    -- Close button
    local closeBtn = Create("TextButton", {
        Name = "Close",
        BackgroundColor3 = Theme.Error,
        Size = UDim2.new(0, 14, 0, 14),
        Text = "",
        Parent = buttonContainer
    })
    AddCorner(closeBtn, UDim.new(1, 0))
    
    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, {
            Size = UDim2.new(0, 0, 0, 0), 
            Position = main.Position + UDim2.new(0, 300, 0, 200)
        }, 0.25)
        task.wait(0.25)
        screenGui:Destroy()
    end)
    
    -- Minimize button
    local minBtn = Create("TextButton", {
        Name = "Minimize",
        BackgroundColor3 = Theme.Warning,
        Size = UDim2.new(0, 14, 0, 14),
        Text = "",
        Parent = buttonContainer
    })
    AddCorner(minBtn, UDim.new(1, 0))
    
    minBtn.MouseButton1Click:Connect(function()
        self.Minimized = not self.Minimized
        local targetSize = self.Minimized and UDim2.new(0, 600, 0, 50) or UDim2.new(0, 600, 0, 400)
        Tween(main, {Size = targetSize}, 0.3)
    end)
    
    -- Sidebar
    local sidebar = Create("Frame", {
        Name = "Sidebar",
        BackgroundColor3 = Theme.Card,
        Position = UDim2.new(0, 0, 0, 50),
        Size = UDim2.new(0, 150, 1, -50),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = main
    })
    
    -- Sidebar corner fixes
    Create("Frame", {
        BackgroundColor3 = Theme.Card,
        Position = UDim2.new(1, -12, 0, 0),
        Size = UDim2.new(0, 12, 1, -12),
        BorderSizePixel = 0,
        Parent = sidebar
    })
    
    Create("Frame", {
        BackgroundColor3 = Theme.Card,
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(0, 12, 0, 12),
        BorderSizePixel = 0,
        Parent = sidebar
    })
    
    -- Tab list container
    local tabContainer = Create("ScrollingFrame", {
        Name = "TabList",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 8),
        Size = UDim2.new(1, -16, 1, -16),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = sidebar
    })
    
    Create("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabContainer
    })
    
    self.TabContainer = tabContainer
    
    -- Content area
    local contentArea = Create("Frame", {
        Name = "ContentArea",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 158, 0, 58),
        Size = UDim2.new(1, -166, 1, -66),
        ClipsDescendants = true,
        Parent = main
    })
    self.ContentArea = contentArea
    
    return self
end

-- Create a new tab
function Window:Tab(config)
    local Tab = self.Ostrapic.Tab.new(self, config)
    table.insert(self.Tabs, Tab)
    
    -- Auto-select first tab
    if #self.Tabs == 1 then
        Tab:Select()
    end
    
    return Tab
end

-- Destroy the window
function Window:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

-- Toggle visibility
function Window:Toggle()
    if self.Main then
        self.Main.Visible = not self.Main.Visible
    end
end

return Window
