local opts = { noremap = true, silent = true }

-- Modes

-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

-- Shoter alias for keymap function
local keymap = vim.api.nvim_set_keymap

-- Remap space as the leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
