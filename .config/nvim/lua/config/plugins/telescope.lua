return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        lazy = false,
        config = function()
            require('telescope').setup {
                defaults = {
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    entry_prefix = "  ",
                    multi_icon = "<>",
                    winblend = 0,
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.95,
                        height = 0.85,
                        -- preview_cutoff = 120,
                        prompt_position = "bottom",

                        horizontal = {
                            preview_width = function(_, cols, _)
                                if cols > 200 then
                                    return math.floor(cols * 0.4)
                                else
                                    return math.floor(cols * 0.6)
                                end
                            end,
                        },

                        vertical = {
                            width = 0.9,
                            height = 0.95,
                            preview_height = 0.5,
                        },

                        flex = {
                            horizontal = {
                                preview_width = 0.9,
                            },
                        },
                    },

                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    scroll_strategy = "cycle",
                    color_devicons = true,


                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            }
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')
            require("telescope").load_extension("fzf")
            local builtin = require("telescope.builtin")
            vim.keymap.set(
                "n", "<leader>pws",
                function()
                    local word = vim.fn.expand("<cword>")
                    builtin.grep_string({ search = word })
                end,
                { desc = "Search current hightlight word" }
            )
            vim.keymap.set(
                "n", "<leader>pWs",
                function()
                    local word = vim.fn.expand("<cWORD>")
                    builtin.grep_string({ search = word })
                end,
                { desc = "Search current hightlight whole word" }
            )
        end,
        keys = function()
            return {
                {
                    "<leader>pf",
                    "<cmd>Telescope find_files<cr>",
                    mode = { "n" },
                    desc = "Find Files",
                },
                {
                    "<leader>ps",
                    "<cmd>Telescope live_grep<cr>",
                    mode = { "n" },
                    desc = "Search for a string and get results live as you type, respects .gitignore",
                },
                {
                    "<leader>ph",
                    "<cmd>Telescope help_tags<cr>",
                    mode = { "n" },
                    desc = "Lists available help tags and opens a new window with the relevant help",
                },
                {
                    "<leader>pd",
                    "<cmd>Telescope diagnostics<cr>",
                    mode = { "n" },
                    desc = "[S]earch [D]iagnostics",
                },
                {
                    "<C-p>",
                    "<cmd>Telescope git_files<cr>",
                    mode = { "n" },
                    desc = "git_files",
                },
            }
        end,
    },
}
