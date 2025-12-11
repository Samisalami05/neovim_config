return {
    "R-nvim/R.nvim",
     -- Only required if you also set defaults.lazy = true
    lazy = false,

	config = function ()
		require("r").setup()
	end
}
