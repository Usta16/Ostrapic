--[[
    Ostrapic UI Library v2.2
    Created by Usta16
    GitHub: https://github.com/Usta16/Ostrapic
]]

local RepoURL = "https://raw.githubusercontent.com/Usta16/Ostrapic/main/"

local function LoadModule(path)
    local url = RepoURL .. path
    local success, result = pcall(function()
        local code = game:HttpGet(url)
        
        if type(code) ~= "string" then
            error("HttpGet did not return a string, got: " .. type(code))
        end
        
        if #code == 0 then
            error("HttpGet returned empty string")
        end
        
        local loadedFunc, loadErr = loadstring(code)
        if not loadedFunc then
            error("loadstring failed: " .. tostring(loadErr))
        end
        
        return loadedFunc()
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
    Version = "2.2.0",
    Creator = "Usta16",
    Theme = {
        Primary = Color3.fromRGB(99, 102, 241),
        Secondary = Color3.fromRGB(129, 140, 248),
        Background = Color3.fromRGB(15, 15, 20),
        Card = Color3.fromRGB(22, 22, 30),
        CardLight = Color3.fromRGB(32, 32, 42),
        Border = Color3.fromRGB(45, 45, 55),
        Text = Color3.fromRGB(240, 240, 245),
        TextDark = Color3.fromRGB(140, 140, 155),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(59, 130, 246),
    }
}

-- Load Core Modules
Ostrapic.Utility = LoadModule("Ostrapic/Utility.lua")
Ostrapic.Icons = LoadModule("Ostrapic/Icons.lua")
Ostrapic.NotifyModule = LoadModule("Ostrapic/Notify.lua")
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
    return self.NotifyModule.new(self, config)
end

function Ostrapic:SetTheme(newTheme)
    for key, value in pairs(newTheme) do
        if self.Theme[key] then
            self.Theme[key] = value
        end
    end
end

-- Icon helper functions
function Ostrapic:GetIcon(name)
    return self.Icons.Get(name)
end

function Ostrapic:AddIcon(name, assetId)
    self.Icons.Add(name, assetId)
end

function Ostrapic:AddIcons(iconTable)
    self.Icons.AddBulk(iconTable)
end

return Ostrapic
