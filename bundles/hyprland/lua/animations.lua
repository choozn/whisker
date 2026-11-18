-- ==========================================
-- ANIMATIONS
-- Hyprland >= 0.55
-- https://wiki.hypr.land/configuring/core/animations/
-- ==========================================

hl.config({
    animations = {
        enabled = true,
    },
})

-- Animation speeds
-- Hyprland speed units: 1 = 100ms
--
-- Replace these defaults with the values from
-- your original theme variables if necessary.

local animation_speed = 5
local animation_speed_secondary = 3
local animation_speed_border_all = 5
local animation_speed_border_inner = 5

-- Helper
local function animation(leaf, speed, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = speed,
        bezier = "default",
        style = style,
    })
end

-- ==========================================
-- WINDOWS
-- ==========================================

animation("windowsIn",
    animation_speed_secondary,
    "popin 0%")

animation("windowsOut",
    animation_speed,
    "popin")

animation("windowsMove",
    animation_speed,
    "slide")

-- ==========================================
-- LAYERS
-- ==========================================

animation("layersIn",
    animation_speed,
    "slide")

animation("layersOut",
    animation_speed,
    "slide")

-- ==========================================
-- FADE
-- ==========================================

animation("fadeIn",
    animation_speed_secondary)

animation("fadeOut",
    animation_speed)

animation("fadeSwitch",
    animation_speed)

animation("fadeShadow",
    animation_speed)

animation("fadeDim",
    animation_speed)

animation("fadeLayersIn",
    animation_speed_secondary)

animation("fadeLayersOut",
    animation_speed)

-- ==========================================
-- BORDERS
-- ==========================================

animation("border",
    animation_speed_border_all)

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = animation_speed_border_inner,
    bezier = "default",
    style = "once",
})

-- ==========================================
-- WORKSPACES
-- ==========================================

animation("workspaces",
    animation_speed,
    "slide")

-- ==========================================
-- SPECIAL WORKSPACES
-- ==========================================

animation("specialWorkspace",
    animation_speed,
    "fade")
