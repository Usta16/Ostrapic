--[[
    Ostrapic UI - Button Component
]]

local Button = {}
Button.__index = Button

function Button.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Button)
    self.Callback = config.Callback or function() end
    
    local Theme = Tab.Theme
    local Tween = Tab.Utility.Tween
    local buttonColor = config.Color or Theme.Primary
    
    local container = Instance.new("TextButton")
    container.Name = "Button"
    container.BackgroundColor3 = buttonColor
    container.Size = UDim2.new(1, 0, 0, 38)
    container.Text = ""
    container.AutoButtonColor = false
    container.BorderSizePixel = 0
    container.Parent = Tab.Content
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = container
    
    self.Container = container
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = config.Title or "Button"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Theme.Text
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Parent = container
    
    container.MouseEnter:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor:Lerp(Color3.new(1, 1, 1), 0.15)}, 0.1)
    end)
    
    container.MouseLeave:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor}, 0.1)
    end)
    
    container.MouseButton1Click:Connect(function()
        Tween(container, {BackgroundColor3 = buttonColor:Lerp(Color3.new(0, 0, 0), 0.2)}, 0.05)
        self.Callback()
        Tween(container, {BackgroundColor3 = buttonColor}, 0.15)
    end)
    
    return self
end

return Button
