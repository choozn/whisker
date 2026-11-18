-- Copyright (C) 2025 choozn
-- Whisker animations
-- Hyprland >= 0.55
-- https://wiki.hypr.land/configuring/core/animations/

hl.config({
    animations = {
        enabled = true,
    },
})

-- Whisker animation speeds
local speed = 3
local secondary = 2.2
local border_all = 3
local border_inner = 1

local function anim(leaf, duration, style)
    hl.animation({
        leaf = leaf,
        enabled = true,
        speed = duration,
        bezier = "default",
        style = style,
    })
end

-- Windows
anim("windowsIn", secondary, "popin 0%")
anim("windowsOut", speed, "popin")
anim("windowsMove", speed, "slide")

-- Layers
anim("layersIn", secondary, "slide")
anim("layersOut", speed, "slide")

-- Fade
anim("fadeIn", secondary)
anim("fadeOut", speed)
anim("fadeSwitch", speed)
anim("fadeShadow", speed)
anim("fadeDim", speed)
anim("fadeLayersIn", secondary)
anim("fadeLayersOut", speed)

-- Borders
anim("border", border_all)

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = border_inner,
    bezier = "default",
    style = "once",
})

-- Workspaces
anim("workspaces", speed, "slide")
anim("specialWorkspace", speed, "fade")
