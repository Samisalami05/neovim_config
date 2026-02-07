return {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
        fuzzy = {
           implementation = "prefer_rust_with_warning",
        },
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			ghost_text = {
				enabled = true,
			},
			menu = {
				draw = {
					treesitter = { "lsp" }
				},
			},
		},
		signature = { enabled = true },
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
	},
}
