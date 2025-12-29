--[[
    Ostrapic UI Library v2.1
    Created by Usta16
    GitHub: https://github.com/Usta16/Ostrapic
]]

local RepoURL = "https://raw.githubusercontent.com/Usta16/Ostrapic/main/"

-- HttpGet function that works with different executors
local function HttpGet(url)
    if syn and syn.request then
        return syn.request({Url = url, Method = "GET"}).Body
    elseif http and http.request then
        return http.request({Url = url, Method = "GET"}).Body
    elseif request then
        return request({Url = url, Method = "GET"}).Body
    elseif httpget then
        return httpget(url)
    elseif game.HttpGet then
        return game:HttpGet(url)
    elseif game.HttpGetAsync then
        return game:HttpGetAsync(url)
    else
        error("No HttpGet function found!")
    end
end

local function LoadModule(path)
    local success, result = pcall(function()
        return loadstring(HttpGet(RepoURL .. path))()
    end)
    if success then
        return result
    else
        warn("[Ostrapic] Failed to load: " .. path)
        warn("[Ostrapic] Error: " .. tostring(result))
        return nil
    end
end

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

-- Load Core Modules
Ostrapic.Utility = LoadModule("Ostrapic/Utility.lua")
Ostrapic.Notify = LoadModule("Ostrapic/Notify.lua")
Ostrapic.Window = LoadModule("Ostrapic/Window.lua")
Ostrapic.Tab = LoadModule("Ostrapic/Tab.lua")

-- Load Components
Ostrapic.Components = {
    Section = LoadModule("Components/Section.lua"),
    Toggle = LoadModule("Components/Toggle.lua"),
    Slider = LoadModule("Components/Slider.lua"),
    Button = LoadModule("Components/Button.lua"),
    Dropdown = LoadModule("Components/Dropdown.lua"),
    Input = LoadModule("Components/Input.lua"),
    Keybind = LoadModule("Components/Keybind.lua"),
    Colorpicker = LoadModule("Components/Colorpicker.lua"),
    Label = LoadModule("Components/Label.lua"),
    Paragraph = LoadModule("Components/Paragraph.lua"),
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
