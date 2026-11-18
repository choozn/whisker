
-- ==========================================
-- ANIMATIONS
-- Whisker Theme
-- Hyprland >= 0.55
-- ==========================================

hl.config({
    animations = {
        enabled = true,
    },
})

-- Whisker animation timings
local animation_speed = 3
local animation_speed_secondary = 2.2
local animation_speed_border_all = 3
local animation_speed_border_inner = 1

-- Animation helper
local function animation(leaf, speed, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = speed,
        bezier = "default",
        style = style,
    })
end

-- Windows
animation("windowsIn", animation_speed_secondary, "popin 0%")
animation("windowsOut", animation_speed, "popin")
animation("windowsMove", animation_speed, "slide")

-- Layers
animation("layersIn", animation_speed, "slide")
animation("layersOut", animation_speed, "slide")

-- Fade
animation("fadeIn", animation_speed_secondary)
animation("fadeOut", animation_speed)
animation("fadeSwitch", animation_speed)
animation("fadeShadow", animation_speed)
animation("fadeDim", animation_speed)
animation("fadeLayersIn", animation_speed_secondary)
animation("fadeLayersOut", animation_speed)

-- Borders
animation("border", animation_speed_border_all)

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = animation_speed_border_inner,
    bezier = "default",
    style = "once",
})

-- Workspaces
animation("workspaces", animation_speed, "slide")

-- Special workspaces
animation("specialWorkspace", animation_speed, "fade")
