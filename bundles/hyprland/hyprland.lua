
-- Copyright (C) 2026 choozn

local config_dir = os.getenv("HOME") .. "/.config/hypr/"

-- Add Hyprland Lua module paths
package.path = config_dir .. "?.lua;" ..
               config_dir .. "?/init.lua;" ..
               package.path

local function load_module(name, fallback)
    local ok, err = pcall(require, name)

    if ok then
        print("[Hyprland] Loaded: " .. name)
        return true
    end

    print("[Hyprland] Failed: " .. name .. ": " .. tostring(err))

    if fallback then
        local fallback_ok, fallback_err = pcall(require, fallback)

        if fallback_ok then
            print("[Hyprland] Loaded fallback: " .. fallback)
            return true
        end

        print(
            "[Hyprland] Fallback failed: " ..
            fallback .. ": " .. tostring(fallback_err)
        )
    end

    return false
end

-- Monitor configuration
load_module("lua.monitors", "lua.monitors.fallback")

-- Optional modules
load_module("lua.workspaces")

-- Main configuration
load_module("lua.bindings")
load_module("lua.settings")
load_module("lua.input")
load_module("lua.rules")
load_module("lua.animations")
load_module("lua.startup")
