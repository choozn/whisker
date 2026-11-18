-- Copyright (C) 2026 choozn
-- Hyprland native Lua configuration
-- https://wiki.hypr.land/configuring/core/binds/
-- Find binds using wev

-- ==========================================
-- COMMANDS
-- ==========================================

local notify = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low"

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"

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

local browser    = "zen-browser"
local launcher   = "vicinae open"
local bluetooth  = "blueman-manager"
local patchman   = "helvum"
local displayman = "nwg-displays"

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function run(command)
    hl.dispatch(hl.dsp.exec_cmd(command))
end

local function notify_user(message)
    run(notify .. " '" .. message .. "'")
end

local function terminal(args)
    run(cmd.alacritty .. " " .. args)
end

-- ==========================================
-- GROUP
-- ==========================================

hl.bind("SUPER + G", function()
    hl.dispatch(hl.dsp.group.toggle())
    notify_user("Toggled Group Mode")
end)

-- ==========================================
-- APPLICATIONS
-- ==========================================

-- Terminal
hl.bind("SUPER + Return", function()
    run(cmd.alacritty)
    run(cmd.fullscreen)
end)

hl.bind("SUPER + SHIFT + Return",
    exec(cmd.alacritty .. " -f"))

hl.bind("SUPER + T",
    exec(cmd.alacritty .. " -F"))

hl.bind("SUPER + SHIFT + T",
    exec(cmd.alacritty .. " -F"))

hl.bind("SUPER + ALT + Return",
    exec(cmd.alacritty .. " -f"))

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

-- Systemd manager
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
-- BRIGHTNESS
-- ==========================================

hl.bind("XF86MonBrightnessUp",
    exec("brightnessctl set 5%+"),
    { repeating = true })

hl.bind("XF86MonBrightnessDown",
    exec("brightnessctl set 5%-"),
    { repeating = true })

-- ==========================================
-- VOLUME
-- ==========================================

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
-- MEDIA
-- ==========================================

hl.bind("XF86AudioNext", exec("mpc next"))
hl.bind("XF86AudioPrev", exec("mpc prev"))
hl.bind("XF86AudioPlay", exec("mpc toggle"))
hl.bind("XF86AudioStop", exec("mpc stop"))

-- ==========================================
-- HARDWARE KEYS
-- ==========================================

hl.bind("XF86Display", exec(displayman))

hl.bind("XF86WLAN",
    exec(cmd.alacritty .. " -F -e " .. cmd.network))

hl.bind("XF86Tools",
    exec(cmd.alacritty .. " -e nvim .config/hypr"))

hl.bind("XF86Bluetooth", exec(bluetooth))

-- Cursor toggle
hl.bind("XF86Favorites", function()
    run(cmd.hidecursor)
    notify_user("Toggled Cursor Mode")
end)

-- Swallow toggle
hl.bind("SHIFT + XF86Favorites", function()
    run(cmd.toggleswallow)
    notify_user("Toggled Swallow Mode")
end)

-- ==========================================
-- SCREENSHOTS
-- ==========================================

hl.bind("Print", exec(cmd.screenshot))
hl.bind("SHIFT + Print", exec(cmd.screenshot))
hl.bind("CTRL + Print", exec(cmd.screenshot))
hl.bind("ALT + Print", exec(cmd.screenshot))
hl.bind("SUPER + Print", exec(cmd.screenshot))
hl.bind("SUPER + SHIFT + S", exec(cmd.screenshot))

-- ==========================================
-- WINDOW MANAGEMENT
-- ==========================================

-- Close active window
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + C", hl.dsp.window.close())
hl.bind("SUPER + ALT + C", hl.dsp.window.close())
hl.bind("SUPER + CTRL + C", hl.dsp.window.close())

-- Exit Hyprland
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())

-- Fullscreen
hl.bind("SUPER + F",
    hl.dsp.window.fullscreen({ action = "toggle" }))

-- Pseudotiling
hl.bind("SUPER + S", hl.dsp.window.pseudo())

-- Floating and centering
hl.bind("SUPER + Space", function()
    hl.dispatch(hl.dsp.window.float())
    hl.dispatch(hl.dsp.window.center())
end)

-- ==========================================
-- WINDOW FOCUS
-- ==========================================

local directions = {
    { "Left", "left" },
    { "Right", "right" },
    { "Up", "up" },
    { "Down", "down" },

    { "H", "left" },
    { "L", "right" },
    { "K", "up" },
    { "J", "down" },
}

for _, b in ipairs(directions) do
    hl.bind("SUPER + " .. b[1],
        hl.dsp.focus({ direction = b[2] }))
end

-- ==========================================
-- MOVE TILED WINDOWS
-- ==========================================

for _, b in ipairs(directions) do
    hl.bind(
        "SUPER + SHIFT + " .. b[1],
        hl.dsp.window.move({
            direction = b[2]
        })
    )
end

-- ==========================================
-- RESIZE WINDOWS
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

for _, b in ipairs(resize_binds) do
    hl.bind(
        "SUPER + CTRL + " .. b[1],
        hl.dsp.window.resize({
            x = b[2],
            y = b[3],
            relative = true
        }),
        { repeating = true }
    )
end

-- ==========================================
-- MOVE FLOATING WINDOWS
-- ==========================================

for _, b in ipairs(resize_binds) do
    hl.bind(
        "SUPER + ALT + " .. b[1],
        hl.dsp.window.move({
            x = b[2],
            y = b[3],
            relative = true
        }),
        { repeating = true }
    )
end

-- ==========================================
-- WINDOW CYCLING
-- ==========================================

hl.bind("SUPER + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({
        mode = "top"
    }))
end)

-- ==========================================
-- WORKSPACES
-- ==========================================

for i = 1, 9 do
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = tostring(i) })
    )

    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({
            workspace = tostring(i)
        })
    )
end

hl.bind("SUPER + 0",
    hl.dsp.focus({ workspace = "10" }))

hl.bind("SUPER + SHIFT + 0",
    hl.dsp.window.move({ workspace = "10" }))

-- Previous / next workspace
hl.bind("CTRL + ALT + Left",
    hl.dsp.focus({ workspace = "e-1" }))

hl.bind("CTRL + ALT + Right",
    hl.dsp.focus({ workspace = "e+1" }))

-- Move windows to previous / next workspace
hl.bind("CTRL + ALT + SHIFT + Left",
    exec("hyprctl dispatch movetoworkspace e-1"))

hl.bind("CTRL + ALT + SHIFT + Right",
    exec("hyprctl dispatch movetoworkspace e+1"))

-- ==========================================
-- MONITOR FOCUS
-- ==========================================

hl.bind("SUPER + O",
    hl.dsp.focus({ monitor = "+1" }))

hl.bind("SUPER + SHIFT + O",
    hl.dsp.focus({ monitor = "-1" }))

-- ==========================================
-- WORKSPACE OPTIONS
-- ==========================================

hl.bind("SUPER + CTRL + F", function()
    run("hyprctl dispatch workspaceopt allfloat")
    notify_user("Toggled All Float Mode")
end)

hl.bind("SUPER + CTRL + S", function()
    run("hyprctl dispatch workspaceopt allpseudo")
    notify_user("Toggled All Pseudo Mode")
end)

-- ==========================================
-- PIN
-- ==========================================

hl.bind("SUPER + SHIFT + P",
    hl.dsp.window.pin())

-- ==========================================
-- MOUSE BINDS
-- ==========================================

-- SUPER + Left mouse: move window
hl.bind("SUPER + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true })

-- SUPER + Right mouse: resize window
hl.bind("SUPER + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true })

-- ==========================================
-- RELOAD
-- ==========================================

hl.bind("SUPER + R",
    exec(cmd.reload))
