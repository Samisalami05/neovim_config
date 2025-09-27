return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = {
		{ "<A-S-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
		{ "<A-S-r>", "<cmd>Telescope live_grep<CR>", desc = "Live Grep (ag)" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				path_display = { "smart" },

				vimgrep_arguments = {
					"ag",
					"--nocolor",
					"--nogroup",
					"--hidden",
					"--column",
					"--smart-case",
				},

				layout_config = {
					horizontal = { width = 0.9 },
					vertical = { width = 0.9 },
				},

				file_ignore_patterns = { "node_modules", ".git/" },
			},
		})
  end,
}
