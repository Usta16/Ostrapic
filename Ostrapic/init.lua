--[[
    Ostrapic UI Library v2.1
    Main Loader
]]

local Ostrapic = {
    Version = "2.1.0",
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

-- Base URL for loading modules
local BaseURL = "https://raw.githubusercontent.com/Usta16/Ostrapic/main/"

-- Load modules
local function LoadModule(path)
    return loadstring(game:HttpGet(BaseURL .. path .. ".lua"))()
end

-- Core modules
Ostrapic.Utility = LoadModule("Utility")
Ostrapic.Notify = LoadModule("Notify")
Ostrapic.Window = LoadModule("Window")

-- Component modules
Ostrapic.Components = {
    Toggle = LoadModule("Components/Toggle"),
    Slider = LoadModule("Components/Slider"),
    Button = LoadModule("Components/Button"),
    Dropdown = LoadModule("Components/Dropdown"),
    Input = LoadModule("Components/Input"),
    Keybind = LoadModule("Components/Keybind"),
    Colorpicker = LoadModule("Components/Colorpicker"),
    Section = LoadModule("Components/Section"),
    Label = LoadModule("Components/Label"),
    Paragraph = LoadModule("Components/Paragraph"),
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
