local M = {}

function M.apply(config)
    -- Rosé Pine (main dark variant) — https://rosepinetheme.com
    config.force_reverse_video_cursor = true
    config.colors = {
        foreground = "#e0def4",
        background = "#191724",

        cursor_bg = "#e0def4",
        cursor_fg = "#191724",
        cursor_border = "#e0def4",

        selection_fg = "#e0def4",
        selection_bg = "#403d52",

        scrollbar_thumb = "#26233a",
        split = "#26233a",

        ansi = { "#26233a", "#eb6f92", "#2276CC", "#f6c177", "#9ccfd8", "#c4a7e7", "#ebbcba", "#e0def4" },
        brights = { "#6e6a86", "#eb6f92", "#2276CC", "#f6c177", "#9ccfd8", "#c4a7e7", "#ebbcba", "#e0def4" },
        indexed = { [16] = "#f6c177", [17] = "#ebbcba" },
    }
end

return M
