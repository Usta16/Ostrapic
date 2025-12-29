--[[
    Ostrapic UI Library v2.1
    Created by Usta16
    
    GitHub: https://github.com/Usta16/Ostrapic
]]

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

-- Base URLs - different paths for main files and components
local RepoURL = "https://raw.githubusercontent.com/Usta16/Ostrapic/main/"
local MainURL = RepoURL .. "Ostrapic/"
local ComponentsURL = RepoURL .. "Components/"

local function LoadModule(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        return result
    else
        warn("[Ostrapic] Failed to load: " .. url)
        warn("[Ostrapic] Error: " .. tostring(result))
        return nil
    end
end

-- Load core modules from Ostrapic folder
Ostrapic.Utility = LoadModule(MainURL .. "Utility.lua")
Ostrapic.Notify = LoadModule(MainURL .. "Notify.lua")
Ostrapic.Window = LoadModule(MainURL .. "Window.lua")
Ostrapic.Tab = LoadModule(MainURL .. "Tab.lua")

-- Load components from Components folder
Ostrapic.Components = {
    Toggle = LoadModule(ComponentsURL .. "Toggle.lua"),
    Slider = LoadModule(ComponentsURL .. "Slider.lua"),
    Button = LoadModule(ComponentsURL .. "Button.lua"),
    Dropdown = LoadModule(ComponentsURL .. "Dropdown.lua"),
    Input = LoadModule(ComponentsURL .. "Input.lua"),
    Keybind = LoadModule(ComponentsURL .. "Keybind.lua"),
    Colorpicker = LoadModule(ComponentsURL .. "Colorpicker.lua"),
    Section = LoadModule(ComponentsURL .. "Section.lua"),
    Label = LoadModule(ComponentsURL .. "Label.lua"),
    Paragraph = LoadModule(ComponentsURL .. "Paragraph.lua"),
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
