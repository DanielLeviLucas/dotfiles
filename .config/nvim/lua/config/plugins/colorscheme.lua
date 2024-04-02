function ColorMyWindow(colorscheme)
    colorscheme = colorscheme or 'dracula'
    vim.cmd.colorscheme(colorscheme)

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

    -- Set border for hover float window
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single" -- You can change "single" to other values like "double", "rounded", etc.
    })
end

return {
    {
        'Mofiqul/dracula.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            local dracula = require("dracula")
            dracula.setup({
                -- customize dracula color palette
                colors = {
                    bg = "#191724",
                    fg = "#F8F8F2",
                    selection = "#282A36",
                    -- comment = "#FF5555",
                    red = "#FF5555",
                    orange = "#FFB86C",
                    yellow = "#F1FA8C",
                    green = "#50fa7b",
                    purple = "#BD93F9",
                    cyan = "#8BE9FD",
                    pink = "#FF79C6",
                    bright_red = "#FF6E6E",
                    bright_green = "#69FF94",
                    bright_yellow = "#FFFFA5",
                    bright_blue = "#D6ACFF",
                    bright_magenta = "#FF92DF",
                    bright_cyan = "#A4FFFF",
                    bright_white = "#FFFFFF",
                    menu = "#3E4452",
                    visual = "#3E4452",
                    gutter_fg = "#4B5263",
                    nontext = "#3B4048",
                    white = "#ABB2BF",
                    black = "#191A21",
                },
                show_end_of_buffer = true,
                transparent_bg = false,
                lualine_bg_color = "#44475a",
                italic_comment = false,
                overrides = {
                },
            })
            vim.cmd("colorscheme dracula")

            ColorMyWindow()
        end,
    }
}
