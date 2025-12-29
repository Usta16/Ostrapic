--[[
    Ostrapic UI - Button Component
]]

local Button = {}
Button.__index = Button

function Button.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Button)
    
    self.Callback = config.Callback or function() end
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    
    local buttonColor = config.Color or Theme.Primary
    
    -- Container/Button
    local container = Create("TextButton", {
        Name = "Button",
        BackgroundColor3 = buttonColor,
        Size = UDim2.new(1, 0, 0, 38),
        Text = "",
        AutoButtonColor = false,
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    self.Container = container
    
    -- Title
    Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Button",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = container
    })
    
    -- Hover effect
    container.MouseEnter:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor:Lerp(Color3.new(1, 1, 1), 0.15)}, 0.1)
    end)
    
    container.MouseLeave:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor}, 0.1)
    end)
    
    -- Click effect
    container.MouseButton1Click:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor:Lerp(Color3.new(0, 0, 0), 0.15)}, 0.05)
        task.wait(0.05)
        Tween(container, {BackgroundColor3 = buttonColor}, 0.1)
        self.Callback()
    end)
    
    return self
end

return Button
