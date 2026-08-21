return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			default_prompt = "Input:",
			title_pos = "left",
			insert_only = true,
			start_in_insert = true,
			border = "rounded",
			relative = "editor",
			prefer_width = 60,
			max_width = { 140, 0.9 },
			min_width = { 20, 0.2 },
			win_options = {
				winblend = 0,
			},
			-- Center top positioning override
			override = function(conf)
				conf.row = 2 -- Top offset
				conf.col = math.floor((vim.o.columns - conf.width) / 2) -- Centered horizontally
				return conf
			end,
		},
	},
}
