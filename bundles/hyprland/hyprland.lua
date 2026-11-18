-- Copyright (C) 2026 choozn

local function load_module(name)
    local ok, err = pcall(require, name)

    if not ok then
        print(
            "[Hyprland] Could not load module '" ..
            name .. "': " .. tostring(err)
        )
    end
end

-- Optional modules
load_module("monitors")
load_module("workspaces")

-- Main configuration modules
load_module("lua.bindings")
load_module("lua.settings")
load_module("lua.input")
load_module("lua.rules")
load_module("lua.animations")
load_module("lua.startup")
