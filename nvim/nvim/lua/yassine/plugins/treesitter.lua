return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	branch = "master",
	build = ":TSUpdate",
	config = function()
		-- Register custom filetypes for Blade and zsh
		vim.filetype.add({
			extension = {
				zsh = "bash",
			},
			pattern = {
				[".*%.blade%.php"] = "blade",
				["%.env.*"] = "sh", -- Map .env files to sh/bash instead of non-existent 'dotenv'
			},
		})

		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"json",
				"python",
				"nginx",
				"make",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"toml",
				"html",
				"php",
				"phpdoc",
				"blade",
				"rust",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			highlight = {
				enable = true,
				-- Disable highlighting on huge files to prevent lag
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			-- Disable treesitter indent to stop buffer line-wiping glitches
			indent = {
				enable = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
