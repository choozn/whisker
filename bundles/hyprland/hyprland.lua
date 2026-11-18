-- Copyright (C) 2026 choozn

local function load_module(name, fallback)
    local ok, err = pcall(require, name)

    if ok then
        return true
    end

    print(
        "[Hyprland] Could not load module '" ..
        name .. "': " .. tostring(err)
    )

    if fallback then
        local fallback_ok, fallback_err = pcall(require, fallback)

        if fallback_ok then
            print("[Hyprland] Loaded fallback module '" .. fallback .. "'")
            return true
        end

        print(
            "[Hyprland] Could not load fallback module '" ..
            fallback .. "': " .. tostring(fallback_err)
        )
    end

    return false
end

-- Optional modules
load_module("lua.monitors", "lua.monitors.fallback")
load_module("lua.workspaces")

-- Main configuration modules
load_module("lua.bindings")
load_module("lua.settings")
load_module("lua.input")
load_module("lua.rules")
load_module("lua.animations")
load_module("lua.startup")
