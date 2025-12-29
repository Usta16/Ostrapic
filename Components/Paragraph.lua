--[[
    Ostrapic UI - Paragraph Component
]]

local Paragraph = {}

function Paragraph.new(Tab, config)
    config = config or {}
    
    local Utility = Tab.Utility
    local Theme = Tab.Theme
    local Create = Utility.Create
    local AddCorner = Utility.AddCorner
    
    local container = Create("Frame", {
        Name = "Paragraph",
        BackgroundColor3 = Theme.Card,
        Size = UDim2.new(1, 0, 0, 75),
        Parent = Tab.Content
    })
    AddCorner(container, UDim.new(0, 10))
    
    local title = Create("TextLabel", {
        Name = "Title",
        Text = config.Title or "Paragraph",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 10),
        Size = UDim2.new(1, -28, 0, 20),
        Parent = container
    })
    
    local content = Create("TextLabel", {
        Name = "Content",
        Text = config.Content or "",
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextColor3 = Theme.TextDark,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 32),
        Size = UDim2.new(1, -28, 1, -42),
        Parent = container
    })
    
    local self = {}
    
    function self:Set(newTitle, newContent)
        if newTitle then title.Text = newTitle end
        if newContent then content.Text = newContent end
    end
    
    return self
end

return Paragraph
