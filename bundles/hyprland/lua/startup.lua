hl.on("hyprland.start", function()
    hl.exec_cmd(
        os.getenv("HOME") .. "/.config/hypr/scripts/startup"
    )
end)
