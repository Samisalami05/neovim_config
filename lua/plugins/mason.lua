return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			-- Setup Lsp
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "bashls", "clangd", "jdtls" },
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = { "lua_ls", "bashls", "clangd", "jdtls" }

			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server);
			end

			-- Diagnostics visuals
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				underline = true,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Fancy icons
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}

