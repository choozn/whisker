local rules = {
    {
        name = "alacritty",
        match = { class = "foot-float|alacritty-float" },
        float = true,
    },
    {
        name = "nwg-displays",
        match = { class = "nwg-displays" },
        float = true,
    },
    {
        name = "blueman",
        match = { class = "blueman-manager" },
        float = true,
    },
    {
        name = "file-operation",
        match = { title = "File Operation Progress" },
        float = true,
    },
    {
        name = "file-replace",
        match = { title = "Confirm to replace files" },
        float = true,
    },
    {
        name = "viewnior",
        match = { title = "Viewnior" },
        center = true,
    },
    {
        name = "firefox",
        match = { class = "firefox" },
        no_blur = true,
    },
    {
        name = "zen",
        match = { class = "zen" },
        no_blur = true,
    },
}

for _, rule in ipairs(rules) do
    hl.window_rule(rule)
end