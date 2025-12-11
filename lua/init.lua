-- [[ Numbering ]]
vim.opt.number = true
vim.opt.relativenumber = true

-- [[ Tabs & Indentation ]]
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- [[ Search ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'

-- [[ Misc ]]
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.scrolloff = 6

-- [[ Colors ]]
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- vim.opt.runtimepath:append('/home/samisalami/Projects/theme-selector/')

-- [[ Keymaps ]]
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Terminal mode: Exit with ESC
map("t", "<ESC>", [[<C-\><C-n>]], opts)

-- FZF keybinds
-- map("n", "<A-S-p>", ":Files<CR>", opts)
-- map("n", "<A-S-r>", ":Ag<CR>", opts)

-- Window navigation
map("n", "<A-S-h>", "<C-w>h", opts)
map("n", "<A-S-j>", "<C-w>j", opts)
map("n", "<A-S-k>", "<C-w>k", opts)
map("n", "<A-S-l>", "<C-w>l", opts)

-- Tab navigation
map("n", "<A-S-n>", "gT", opts)
map("n", "<A-S-m>", "gt", opts)

vim.keymap.set("n", "<C-h>", function()
    require("alpha").start()
end, { noremap = true, silent = true })


-- Neovide settings
if vim.g.neovide then
	vim.print("Found neovide");
	--vim.g.neovide_cursor_vfx_mode = "pixiedust";
end
