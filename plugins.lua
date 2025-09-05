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
	
	-- themes
	"rose-pine/neovim",
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"savq/melange-nvim"
	},
	-- end of themes
	
	"ap/vim-css-color",
	"neovim/nvim-lspconfig",
	{
		"ms-jpq/coq-nvim",
		branch = "coq",
	},
	{
		"ms-jpq/coq.artifacts",
		branch = "artifacts",
	},
	{
		"ms-jpq/coq.thirdparty",
		branch = "3p",
	},
	--{
		--"ms-jpq/coq_nvim",
		--branc = "coq",
	--},
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

vim.lsp.config("clangd", coq.lsp_ensure_capabilities());
vim.lsp.enable("clangd");

local options = {noremap=true, silent=true}
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', options);

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	end,
})
