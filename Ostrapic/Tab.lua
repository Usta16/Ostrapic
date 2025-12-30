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
    self.Icons = Window.Ostrapic.Icons
    self.Components = Window.Components
    self.Elements = {}
    self.Title = config.Title or "Tab"
    self.Icon = config.Icon
    
    local Create = self.Utility.Create
    local Tween = self.Utility.Tween
    local AddCorner = self.Utility.AddCorner
    local Theme = self.Theme
    
    -- Tab button
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
    
    -- Tab content holder
    local tabContent = Create("Frame", {
        Name = "TabContent",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = tabButton
    })
    
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 8),
        Parent = tabContent
    })
    
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 12),
        Parent = tabContent
    })
    
    -- Icon (if provided)
    if config.Icon then
        local iconId = self.Icons.Get(config.Icon)
        local iconImage = Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 16, 0, 16),
            Image = iconId,
            ImageColor3 = Theme.TextDark,
            ScaleType = Enum.ScaleType.Fit,
            Parent = tabContent
        })
        self.IconImage = iconImage
    end
    
    -- Tab label
    local tabLabel = Create("TextLabel", {
        Name = "Label",
        Text = self.Title,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -30, 1, 0),
        Parent = tabContent
    })
    self.Label = tabLabel
    
    -- Scrolling content area
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
    
    -- Tab selection
    tabButton.MouseButton1Click:Connect(function()
        self:Select()
    end)
    
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

function Tab:Select()
    local Window = self.Window
    local Tween = self.Utility.Tween
    local Theme = self.Theme
    
    for _, tab in pairs(Window.Tabs) do
        tab.Content.Visible = false
        Tween(tab.Button, {BackgroundTransparency = 1}, 0.15)
        Tween(tab.Label, {TextColor3 = Theme.TextDark}, 0.15)
        if tab.IconImage then
            Tween(tab.IconImage, {ImageColor3 = Theme.TextDark}, 0.15)
        end
    end
    
    self.Content.Visible = true
    Tween(self.Button, {BackgroundTransparency = 0}, 0.15)
    Tween(self.Label, {TextColor3 = Theme.Text}, 0.15)
    if self.IconImage then
        Tween(self.IconImage, {ImageColor3 = Theme.Primary}, 0.15)
    end
    
    Window.CurrentTab = self
end

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
