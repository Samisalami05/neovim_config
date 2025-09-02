-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require "nvim-treesitter.configs"
			configs.setup {
				ensure_installed = {
					"c",
				},
				highlight = {
					enable = true
				}
			}
		end,
	},
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"rose-pine/neovim",
	"neovim/nvim-lspconfig",
	{
		"ms-jpq/coq_nvim",
		branc = "coq",
	},
	--
	--{
		--"ms-jpg/coq.artifacts",
		--branc = "artifacts",
	--},
	--{
		--"ms-jpg/coq.thirdparty",
		--branc = "3p",
	--},

})

vim.lsp.enable("clangd");
