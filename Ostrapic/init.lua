--[[
    Ostrapic UI Library v2.1
    Created by Usta16
    GitHub: https://github.com/Usta16/Ostrapic
]]

local RepoURL = "https://raw.githubusercontent.com/Usta16/Ostrapic/main/"

local Ostrapic = {
    Version = "2.1.0",
    Creator = "Usta16",
    Theme = {
        Primary = Color3.fromRGB(99, 102, 241),
        Background = Color3.fromRGB(15, 15, 20),
        Card = Color3.fromRGB(22, 22, 30),
        CardLight = Color3.fromRGB(32, 32, 42),
        Border = Color3.fromRGB(45, 45, 55),
        Text = Color3.fromRGB(240, 240, 245),
        TextDark = Color3.fromRGB(140, 140, 155),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
    }
}

-- Load Utility
Ostrapic.Utility = loadstring(game:HttpGet(RepoURL .. "Ostrapic/Utility.lua"))()

-- Load Notify
Ostrapic.Notify = loadstring(game:HttpGet(RepoURL .. "Ostrapic/Notify.lua"))()

-- Load Window
Ostrapic.Window = loadstring(game:HttpGet(RepoURL .. "Ostrapic/Window.lua"))()

-- Load Tab
Ostrapic.Tab = loadstring(game:HttpGet(RepoURL .. "Ostrapic/Tab.lua"))()

-- Load Components
Ostrapic.Components = {
    Section = loadstring(game:HttpGet(RepoURL .. "Components/Section.lua"))(),
    Toggle = loadstring(game:HttpGet(RepoURL .. "Components/Toggle.lua"))(),
    Slider = loadstring(game:HttpGet(RepoURL .. "Components/Slider.lua"))(),
    Button = loadstring(game:HttpGet(RepoURL .. "Components/Button.lua"))(),
    Dropdown = loadstring(game:HttpGet(RepoURL .. "Components/Dropdown.lua"))(),
    Input = loadstring(game:HttpGet(RepoURL .. "Components/Input.lua"))(),
    Keybind = loadstring(game:HttpGet(RepoURL .. "Components/Keybind.lua"))(),
    Colorpicker = loadstring(game:HttpGet(RepoURL .. "Components/Colorpicker.lua"))(),
    Label = loadstring(game:HttpGet(RepoURL .. "Components/Label.lua"))(),
    Paragraph = loadstring(game:HttpGet(RepoURL .. "Components/Paragraph.lua"))(),
}

function Ostrapic:CreateWindow(config)
    return self.Window.new(self, config)
end

function Ostrapic:Notify(config)
    return self.Notify.new(self, config)
end

function Ostrapic:SetTheme(newTheme)
    for key, value in pairs(newTheme) do
        if self.Theme[key] then
            self.Theme[key] = value
        end
    end
end

return Ostrapic
