--[[
    Ostrapic UI - Dropdown Component
]]

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(Tab, config)
    config = config or {}
    
    local self = setmetatable({}, Dropdown)
    
    self.Values = config.Values or {}
    self.Value = config.Default or config.Value
    self.Multi = config.Multi or false
    self.Selected = self.Multi and {} or nil
    self.Open = false
    self.Callback = config.Callback or function() end
    self.Flag = config.Flag
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local Tween = Utility.Tween
    local AddCorner = Utility.AddCorner
    
    -- Container
    local container = Create("Frame", {
        Name = "Dropdown",
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
        Text = config.Title or "Dropdown",
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(0.5, 0, 0, 44),
        Parent = container
    })
    
    -- Selected label
    local selectedLabel = Create("TextLabel", {
        Name = "Selected",
        Text = self.Value or "Select...",
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.5, -38, 0, 44),
        Parent = container
    })
    self.SelectedLabel = selectedLabel
    
    -- Arrow
    local arrow = Create("TextLabel", {
        Name = "Arrow",
        Text = "▼",
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = Theme.TextDark,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -28, 0, 0),
        Size = UDim2.new(0, 20, 0, 44),
        Parent = container
    })
    self.Arrow = arrow
    
    -- Options frame
    local optionsFrame = Create("Frame", {
        Name = "Options",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 48),
        Size = UDim2.new(1, -16, 0, 0),
        Parent = container
    })
    
    Create("UIListLayout", {
        Padding = UDim.new(0, 4),
        Parent = optionsFrame
    })
    
    self.OptionsFrame = optionsFrame
    
    -- Refresh options
    local function RefreshOptions()
        for _, child in pairs(optionsFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        for _, val in pairs(self.Values) do
            local opt = Create("TextButton", {
                BackgroundColor3 = Theme.CardLight,
                Size = UDim2.new(1, 0, 0, 32),
                Text = "",
                AutoButtonColor = false,
                Parent = optionsFrame
            })
            AddCorner(opt, UDim.new(0, 6))
            
            local isSelected = self.Multi and self.Selected[val] or self.Value == val
            
            Create("TextLabel", {
                Text = tostring(val),
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextColor3 = isSelected and Theme.Primary or Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -24, 1, 0),
                Parent = opt
            })
            
            opt.MouseEnter:Connect(function()
                Tween(opt, {BackgroundColor3 = Theme.Card:Lerp(Color3.new(1,1,1), 0.08)}, 0.1)
            end)
            
            opt.MouseLeave:Connect(function()
                Tween(opt, {BackgroundColor3 = Theme.CardLight}, 0.1)
            end)
            
            opt.MouseButton1Click:Connect(function()
                if self.Multi then
                    self.Selected[val] = not self.Selected[val]
                    local list = {}
                    for v, s in pairs(self.Selected) do
                        if s then table.insert(list, v) end
                    end
                    selectedLabel.Text = #list > 0 and table.concat(list, ", ") or "Select..."
                    self.Callback(list)
                else
                    self.Value = val
                    selectedLabel.Text = tostring(val)
                    self.Callback(val)
                end
                RefreshOptions()
            end)
        end
        
        local count = #self.Values
        optionsFrame.Size = UDim2.new(1, -16, 0, count * 36)
    end
    
    RefreshOptions()
    self.RefreshOptions = RefreshOptions
    
    -- Header click
    local header = Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 44),
        Text = "",
        Parent = container
    })
    
    header.MouseButton1Click:Connect(function()
        self.Open = not self.Open
        local count = #self.Values
        local height = self.Open and (52 + count * 36) or 44
        Tween(container, {Size = UDim2.new(1, 0, 0, height)}, 0.25)
        Tween(arrow, {Rotation = self.Open and 180 or 0}, 0.25)
    end)
    
    -- Methods
    function self:Set(value)
        if self.Multi and type(value) == "table" then
            self.Selected = {}
            for _, v in pairs(value) do
                self.Selected[v] = true
            end
            selectedLabel.Text = #value > 0 and table.concat(value, ", ") or "Select..."
        else
            self.Value = value
            selectedLabel.Text = tostring(value)
        end
        RefreshOptions()
    end
    
    function self:Refresh(newValues)
        self.Values = newValues
        RefreshOptions()
    end
    
    function self:Get()
        if self.Multi then
            local list = {}
            for v, s in pairs(self.Selected) do
                if s then table.insert(list, v) end
            end
            return list
        end
        return self.Value
    end
    
    return self
end

return Dropdown
