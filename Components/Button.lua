--[[
    Ostrapic UI - Button Component (FIXED FOREVER)
]]

local Button = {}
Button.__index = Button

local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad)

function Button.new(Tab, config)
	config = config or {}
	
	local self = setmetatable({}, Button)
	self.Callback = config.Callback or function() end

	local buttonColor = config.Color or Tab.Theme.Primary

	local container = Instance.new("TextButton")
	container.Name = "Button"
	container.Size = UDim2.new(1, 0, 0, 38)
	container.BackgroundColor3 = buttonColor
	container.BorderSizePixel = 0
	container.AutoButtonColor = false
	container.Text = ""
	container.Parent = Tab.Content

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = container

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Text = config.Title or "Button"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 14
	title.TextColor3 = Tab.Theme.Text
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, 1, 0)
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.Parent = container

	self.Container = container

	-- Hover
	container.MouseEnter:Connect(function()
		TweenService:Create(container, tweenInfo, {BackgroundColor3 = buttonColor:Lerp(Color3.new(1,1,1), 0.15)}):Play()
	end)

	container.MouseLeave:Connect(function()
		TweenService:Create(container, tweenInfo, {BackgroundColor3 = buttonColor}):Play()
	end)

	-- Click + Callback
	container.MouseButton1Click:Connect(function()
		TweenService:Create(container, TweenInfo.new(0.08), {BackgroundColor3 = buttonColor:Lerp(Color3.new(0,0,0), 0.25)}):Play()
		task.spawn(self.Callback)  -- THIS IS THE KEY LINE
		task.delay(0.08, function()
			TweenService:Create(container, tweenInfo, {BackgroundColor3 = buttonColor}):Play()
		end)
	end)

	return self
end

return Button
