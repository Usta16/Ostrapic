--[[
    Ostrapic UI - Tab Module
]]

local Tab = {}
Tab.__index = Tab

function Tab.new(Window, config)
    config = config or {}
    
    local self = setmetatable({}, Tab)
    
    self.Window = Window
    self.Ostrapic = Window.Ostrapic
    self.Theme = Window.Theme
    self.Utility = Window.Utility
    self.Components = Window.Components
    self.Elements = {}
    self.Title = config.Title or "Tab"
    
    local Create = self.Utility.Create
    local Tween = self.Utility.Tween
    local AddCorner = self.Utility.AddCorner
    local Theme = self.Theme
    
    -- Tab button in sidebar
    local tabButton = Create("TextButton", {
        Name = self.Title,
        BackgroundColor3 = Theme.CardLight,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 36),
        Text = "",
        AutoButtonColor = false,
        Parent = Window.TabContainer
    })
    AddCorner(tabButton, UDim.new(0, 8))
    self.Button = tabButton
    
    -- Tab label
    local tabLabel = Create("TextLabel", {
        Name = "Label",
        Text = self.Title,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Parent = tabButton
    })
    self.Label = tabLabel
    
    -- Tab content (scrolling frame)
    local content = Create("ScrollingFrame", {
        Name = self.Title .. "_Content",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = Window.ContentArea
    })
    
    Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = content
    })
    
    Create("UIPadding", {
        PaddingRight = UDim.new(0, 8),
        Parent = content
    })
    
    self.Content = content
    
    -- Tab button click handler
    tabButton.MouseButton1Click:Connect(function()
        self:Select()
    end)
    
    -- Hover effects
    tabButton.MouseEnter:Connect(function()
        if Window.CurrentTab ~= self then
            Tween(tabButton, {BackgroundTransparency = 0.5}, 0.1)
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if Window.CurrentTab ~= self then
            Tween(tabButton, {BackgroundTransparency = 1}, 0.1)
        end
    end)
    
    return self
end

-- Select this tab
function Tab:Select()
    local Window = self.Window
    local Tween = self.Utility.Tween
    local Theme = self.Theme
    
    -- Deselect all other tabs
    for _, tab in pairs(Window.Tabs) do
        tab.Content.Visible = false
        Tween(tab.Button, {BackgroundTransparency = 1}, 0.15)
        Tween(tab.Label, {TextColor3 = Theme.TextDark}, 0.15)
    end
    
    -- Select this tab
    self.Content.Visible = true
    Tween(self.Button, {BackgroundTransparency = 0}, 0.15)
    Tween(self.Label, {TextColor3 = Theme.Text}, 0.15)
    
    Window.CurrentTab = self
end

-- Add components
function Tab:Section(config)
    return self.Components.Section.new(self, config)
end

function Tab:Toggle(config)
    local element = self.Components.Toggle.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Slider(config)
    local element = self.Components.Slider.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Button(config)
    local element = self.Components.Button.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Dropdown(config)
    local element = self.Components.Dropdown.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Input(config)
    local element = self.Components.Input.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Keybind(config)
    local element = self.Components.Keybind.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Colorpicker(config)
    local element = self.Components.Colorpicker.new(self, config)
    table.insert(self.Elements, element)
    return element
end

function Tab:Label(config)
    return self.Components.Label.new(self, config)
end

function Tab:Paragraph(config)
    return self.Components.Paragraph.new(self, config)
end

return Tab
