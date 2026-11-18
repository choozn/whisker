
-- General
hl.config({
    general = {
        layout = "dwindle",
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,
        gaps_workspaces = 0,
        no_focus_fallback = false,
        resize_on_border = false,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
        allow_tearing = false,
        resize_corner = 0,
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive = false,
        dim_strength = 0.5,
        dim_special = 0.2,
        dim_around = 0.4,

        blur = {
            enabled = true,
            size = 8,
            xray = true,
            ignore_opacity = false,
        },

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            sharp = false,
            offset = { 0, 0 },
            scale = 1.0,
        },
    },

    dwindle = {
        force_split = 0,
        preserve_split = false,
        smart_split = false,
        smart_resizing = true,
        permanent_direction_override = false,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
        split_bias = 2,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = false,
        force_default_wallpaper = 0,
        vrr = 0,
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = false,
        always_follow_on_dnd = true,
        layers_hog_keyboard_focus = true,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        enable_swallow = true,
        swallow_regex = "^(Alacritty|kitty|footclient)$",
        focus_on_activate = true,
        mouse_move_focuses_monitor = true,
        allow_session_lock_restore = false,
        background_color = 0x000000,
        close_special_on_empty = true,
        on_focus_under_fullscreen = 1,
        exit_window_retains_fullscreen = 0,
        initial_workspace_tracking = 1,
        middle_click_paste = false,
    },

    xwayland = {
        enabled = true,
        use_nearest_neighbor = true,
        force_zero_scaling = true,
    },

    opengl = {
        nvidia_anti_flicker = true,
    },

    cursor = {
        no_hardware_cursors = false,
        no_break_fs_vrr = false,
        min_refresh_rate = 30,
        hotspot_padding = 1,
        inactive_timeout = 0,
        no_warps = false,
        persistent_warps = false,
        warp_on_change_workspace = false,
        zoom_factor = 1.0,
        zoom_rigid = false,
        enable_hyprcursor = true,
        hide_on_key_press = false,
        hide_on_touch = false,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
        enforce_permissions = false,
    },
})
