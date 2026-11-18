
-- Copyright (C) 2025 choozn
-- Converted to Hyprland Lua configuration (0.55+)
-- Reference: https://wiki.hypr.land/configuring/core/binds/
-- Find key names using wev

-- ==========================================
-- Variables
-- ==========================================

local notify = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low"

local scripts = "~/.config/hypr/scripts/"

local cmd = {
    alacritty     = scripts .. "alacritty",
    volume        = scripts .. "volume",
    backlight     = scripts .. "brightness",
    screenshot    = scripts .. "screenshot",
    lockscreen    = scripts .. "lockscreen",
    colorpicker   = scripts .. "colorpicker",
    reload        = scripts .. "reload",
    fullscreen    = scripts .. "fullscreen",
    edit          = scripts .. "editlauncher",
    powermenu     = scripts .. "powermenu",
    network       = scripts .. "network",
    audiomixer    = scripts .. "audiomixer",
    systemd       = scripts .. "systemdservices",
    hidecursor    = scripts .. "togglecursor",
    toggleswallow = scripts .. "toggleswallow",
}

local browser     = "zen-browser"
local launcher    = "vicinae open"
local bluetooth   = "blueman-manager"
local patchman    = "helvum"
local displayman  = "nwg-displays"

-- ==========================================
-- Helpers
-- ==========================================

-- Execute external commands without blocking Lua callbacks.
local function exec(command)
    return hl.dsp.exec_cmd(command)
end

-- Compatibility helper for existing Hyprland dispatchers.
local function dispatch(name, args)
    local command = "hyprctl dispatch " .. name

    if args and args ~= "" then
        command = command .. " " .. args
    end

    return exec(command)
end

-- Run multiple actions on one keybind.
local function actions(key, callback, flags)
    hl.bind(key, callback, flags)
end

local function notify_user(message)
    return exec(notify .. " " .. "'" .. message .. "'")
end

local function terminal(command)
    return exec(cmd.alacritty .. " " .. command)
end

-- ==========================================
-- Group
-- ==========================================

actions("SUPER + G", function()
    hl.dispatch(hl.dsp.group.toggle())
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled Group Mode'"
    ))
end)

-- ==========================================
-- Applications
-- ==========================================

-- Terminal
hl.bind("SUPER + Return", exec(cmd.alacritty))
hl.bind("SUPER + Return", exec(cmd.fullscreen))

hl.bind("SUPER + SHIFT + Return", exec(cmd.alacritty .. " -f"))
hl.bind("SUPER + T", exec(cmd.alacritty .. " -F"))
hl.bind("SUPER + SHIFT + T", exec(cmd.alacritty .. " -F"))
hl.bind("SUPER + ALT + Return", exec(cmd.alacritty .. " -f"))

-- Editor
hl.bind("SUPER + E",
    exec(cmd.alacritty .. " -e " .. cmd.edit))

-- Browser
hl.bind("SUPER + W", exec(browser))
hl.bind("SUPER + SHIFT + W", exec(browser))

-- Launcher
hl.bind("SUPER + D", exec(launcher))
hl.bind("ALT + F1", exec(launcher))

-- Power menu
hl.bind("SUPER + X",
    exec(cmd.alacritty .. " -f -e " .. cmd.powermenu))

-- Network manager
hl.bind("SUPER + N",
    exec(cmd.alacritty .. " -F -e " .. cmd.network))

-- Bluetooth
hl.bind("SUPER + B", exec(bluetooth))

-- Systemd services
hl.bind("SUPER + V",
    exec(cmd.alacritty .. " -F -e " .. cmd.systemd))

-- Display manager
hl.bind("SUPER + comma", exec(displayman))

-- Audio manager
hl.bind("SUPER + M",
    exec(cmd.alacritty .. " -F -e " .. cmd.audiomixer))

hl.bind("SUPER + SHIFT + M", exec(patchman))

-- Color picker
hl.bind("SUPER + P", exec(cmd.colorpicker))

-- Lock screen
hl.bind("CTRL + ALT + L", exec("hyprlock"))
hl.bind("SUPER + Escape", exec("hyprlock"))

-- ==========================================
-- Brightness and volume
-- ==========================================

-- Brightness
hl.bind("XF86MonBrightnessUp",
    exec("brightnessctl set 5%+"),
    { repeating = true })

hl.bind("XF86MonBrightnessDown",
    exec("brightnessctl set 5%-"),
    { repeating = true })

-- Volume
hl.bind("XF86AudioRaiseVolume",
    exec(cmd.volume .. " --inc"),
    { repeating = true })

hl.bind("XF86AudioLowerVolume",
    exec(cmd.volume .. " --dec"),
    { repeating = true })

hl.bind("XF86AudioMute",
    exec(cmd.volume .. " --toggle"))

hl.bind("XF86AudioMicMute",
    exec(cmd.volume .. " --toggle-mic"))

-- ==========================================
-- Media controls
-- ==========================================

hl.bind("XF86AudioNext", exec("mpc next"))
hl.bind("XF86AudioPrev", exec("mpc prev"))
hl.bind("XF86AudioPlay", exec("mpc toggle"))
hl.bind("XF86AudioStop", exec("mpc stop"))

-- ==========================================
-- Hardware keys
-- ==========================================

hl.bind("XF86Display", exec(displayman))
hl.bind("XF86WLAN",
    exec(cmd.alacritty .. " -F -e " .. cmd.network))

hl.bind("XF86Tools",
    exec(cmd.alacritty .. " -e nvim .config/hypr"))

hl.bind("XF86Bluetooth", exec(bluetooth))

-- Cursor toggle
actions("XF86Favorites", function()
    hl.dispatch(hl.dsp.exec_cmd(cmd.hidecursor))
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled Cursor Mode'"
    ))
end)

-- Swallow toggle
actions("SHIFT + XF86Favorites", function()
    hl.dispatch(hl.dsp.exec_cmd(cmd.toggleswallow))
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled Swallow Mode'"
    ))
end)

-- ==========================================
-- Screenshots
-- ==========================================

hl.bind("Print", exec(cmd.screenshot))
hl.bind("SHIFT + Print", exec(cmd.screenshot))
hl.bind("CTRL + Print", exec(cmd.screenshot))
hl.bind("ALT + Print", exec(cmd.screenshot))
hl.bind("SUPER + Print", exec(cmd.screenshot))
hl.bind("SUPER + SHIFT + S", exec(cmd.screenshot))

-- ==========================================
-- Window management
-- ==========================================

hl.bind("SUPER + Q", dispatch("killactive"))
hl.bind("SUPER + C", dispatch("killactive"))
hl.bind("SUPER + SHIFT + C", dispatch("killactive"))
hl.bind("SUPER + ALT + C", dispatch("killactive"))
hl.bind("SUPER + CTRL + C", dispatch("killactive"))

-- Exit Hyprland
hl.bind("CTRL + ALT + Delete", dispatch("exit"))

-- Fullscreen
hl.bind("SUPER + F", dispatch("fullscreen", "0"))

-- Pseudotiling
hl.bind("SUPER + S", dispatch("pseudo"))

-- Floating
hl.bind("SUPER + Space", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "hyprctl dispatch togglefloating"
    ))
    hl.dispatch(hl.dsp.exec_cmd(
        "hyprctl dispatch centerwindow"
    ))
end)

-- ==========================================
-- Focus movement
-- ==========================================

-- Arrow keys
hl.bind("SUPER + Left", dispatch("movefocus", "l"))
hl.bind("SUPER + Right", dispatch("movefocus", "r"))
hl.bind("SUPER + Up", dispatch("movefocus", "u"))
hl.bind("SUPER + Down", dispatch("movefocus", "d"))

-- Vim keys
hl.bind("SUPER + H", dispatch("movefocus", "l"))
hl.bind("SUPER + L", dispatch("movefocus", "r"))
hl.bind("SUPER + K", dispatch("movefocus", "u"))
hl.bind("SUPER + J", dispatch("movefocus", "d"))

-- ==========================================
-- Move windows
-- ==========================================

-- Arrow keys
hl.bind("SUPER + SHIFT + Left", dispatch("movewindow", "l"))
hl.bind("SUPER + SHIFT + Right", dispatch("movewindow", "r"))
hl.bind("SUPER + SHIFT + Up", dispatch("movewindow", "u"))
hl.bind("SUPER + SHIFT + Down", dispatch("movewindow", "d"))

-- Vim keys
hl.bind("SUPER + SHIFT + H", dispatch("movewindow", "l"))
hl.bind("SUPER + SHIFT + L", dispatch("movewindow", "r"))
hl.bind("SUPER + SHIFT + K", dispatch("movewindow", "u"))
hl.bind("SUPER + SHIFT + J", dispatch("movewindow", "d"))

-- ==========================================
-- Resize windows
-- ==========================================

local resize_binds = {
    { "Left",  -20,   0 },
    { "Right",  20,   0 },
    { "Up",      0, -20 },
    { "Down",    0,  20 },

    { "H",     -20,   0 },
    { "L",      20,   0 },
    { "K",       0, -20 },
    { "J",       0,  20 },
}

for _, bind in ipairs(resize_binds) do
    hl.bind(
        "SUPER + CTRL + " .. bind[1],
        dispatch("resizeactive", bind[2] .. " " .. bind[3]),
        { repeating = true }
    )
end

-- ==========================================
-- Move floating windows
-- ==========================================

local move_binds = {
    { "Left",  -20,   0 },
    { "Right",  20,   0 },
    { "Up",      0, -20 },
    { "Down",    0,  20 },

    { "H",     -20,   0 },
    { "L",      20,   0 },
    { "K",       0, -20 },
    { "J",       0,  20 },
}

for _, bind in ipairs(move_binds) do
    hl.bind(
        "SUPER + ALT + " .. bind[1],
        dispatch("moveactive", bind[2] .. " " .. bind[3]),
        { repeating = true }
    )
end

-- ==========================================
-- Window cycling
-- ==========================================

actions("SUPER + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({
        mode = "top"
    }))
end)

-- ==========================================
-- Workspaces
-- ==========================================

for i = 1, 9 do
    hl.bind(
        "SUPER + " .. i,
        dispatch("workspace", tostring(i))
    )

    hl.bind(
        "SUPER + SHIFT + " .. i,
        dispatch("movetoworkspace", tostring(i))
    )
end

hl.bind("SUPER + 0", dispatch("workspace", "10"))
hl.bind("SUPER + SHIFT + 0",
    dispatch("movetoworkspace", "10"))

-- Previous / next workspace
hl.bind("CTRL + ALT + Left",
    dispatch("workspace", "e-1"))

hl.bind("CTRL + ALT + Right",
    dispatch("workspace", "e+1"))

-- Move window to previous / next workspace
hl.bind("CTRL + ALT + SHIFT + Left",
    dispatch("movetoworkspace", "e-1"))

hl.bind("CTRL + ALT + SHIFT + Right",
    dispatch("movetoworkspace", "e+1"))

-- ==========================================
-- Monitor focus
-- ==========================================

hl.bind("SUPER + O", dispatch("focusmonitor", "+1"))
hl.bind("SUPER + SHIFT + O", dispatch("focusmonitor", "-1"))

-- ==========================================
-- Workspace options
-- ==========================================

actions("SUPER + CTRL + F", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "hyprctl dispatch workspaceopt allfloat"
    ))
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled All Float Mode'"
    ))
end)

actions("SUPER + CTRL + S", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "hyprctl dispatch workspaceopt allpseudo"
    ))
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled All Pseudo Mode'"
    ))
end)

-- ==========================================
-- Pin
-- ==========================================

actions("SUPER + SHIFT + P", function()
    hl.dispatch(hl.dsp.exec_cmd("hyprctl dispatch pin"))
    hl.dispatch(hl.dsp.exec_cmd(
        notify .. " 'Toggled Pin'"
    ))
end)

-- ==========================================
-- Mouse binds
-- ==========================================

hl.bind("SUPER + mouse:272",
    dispatch("movewindow"),
    { mouse = true })

hl.bind("SUPER + mouse:273",
    dispatch("resizewindow"),
    { mouse = true })

-- ==========================================
-- Reload configuration
-- ==========================================

hl.bind("SUPER + R", exec(cmd.reload))
