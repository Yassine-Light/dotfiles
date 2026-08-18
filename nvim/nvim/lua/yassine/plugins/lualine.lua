return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status")
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_x = {
					-- Lazy.nvim updates component
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e3b" }, -- Gruvbox orange accent
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
