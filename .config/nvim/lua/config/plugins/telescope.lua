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
            pcall(require("telescope").load_extension, "fzf")
            require("telescope").load_extension("fzf")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>pws", function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end, { desc = "Search current hightlight word" })

            vim.keymap.set("n", "<leader>pWs", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end, { desc = "Search current hightlight whole word" })

            vim.keymap.set("n", "<leader>ph", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>p.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "[S]earch Git Files" })

            vim.keymap.set("n", "<leader>/", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "[/] Fuzzily search in current buffer" })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set("n", "<leader>p/", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, { desc = "[S]earch [/] in Open Files" })
        end,
    },
}
