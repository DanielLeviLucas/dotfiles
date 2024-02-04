-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

-- clear search highlights
keymap.set(
    "n", "<leader>nh",
    ":nohl<CR>",
    { desc = "Clear search highlights" }
)

-- NETRW
keymap.set(
    "n", "<leader>pv",
    vim.cmd.Ex,
    { desc = "Open netrw" }
)

-- vertical line swapping
keymap.set("v", "J",
    ":m '>+1<CR>gv=gv",
    { desc = "move current line below" }

)
keymap.set("v", "K",
    ":m '<-2<CR>gv=gv",
    { desc = "move current line above" }
)

-- Search nagivation tweaks
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<leader>to",
    "<cmd>tabnew<CR>",
    { desc = "Open new tab" }
)
keymap.set("n", "<leader>tx",
    "<cmd>tabclose<CR>",
    { desc = "Close current tab" }
)
keymap.set("n", "<leader>tn",
    "<cmd>tabn<CR>",
    { desc = "Go to next tab" }
)
keymap.set("n", "<leader>tp",
    "<cmd>tabp<CR>",
    { desc = "Go to previous tab" }
)
keymap.set("n", "<leader>tf",
    "<cmd>tabnew %<CR>",
    { desc = "Open current buffer in new tab" }
)

keymap.set("x", "<leader>p",
    [["_dP]],
    { desc = "Paste without copying the buffer" }
)

-- Copy selection buffer to system clipboard
keymap.set({ "n", "v" },
    "<leader>y", [["+y]],
    { desc = "Copy selection buffer to system clipboard" }
)
keymap.set("n", "<leader>Y",
    [["+Y]],
    { desc = "Copy selection buffer to system clipboard" }
)

-- Deletes the current line without yanking it into the default register.
keymap.set(
    { "n", "v" }, "<leader>d", [["_d]],
    { desc = "Deletes the current line without yanking it into the default register" }
)

keymap.set("n", "Q",
    "<nop>",
    { desc = "No Action/No operation" }
)

-- Disable arrow navigation
keymap.set("n", "<Up>", "<nop>")
keymap.set("n", "<Down>", "<nop>")
keymap.set("n", "<Right>", "<nop>")
keymap.set("n", "<Left>", "<nop>")

-- File navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set({ 'n', 'v' },
    '<Space>', '<Nop>',
    { silent = true }
)
