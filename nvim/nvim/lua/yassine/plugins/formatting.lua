return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Frontend & JS/TS
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				tsx = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },

				-- PHP & Laravel Blade
				php = { "pint" },
				blade = { "pint" },

				-- Systems & Compiled
				c = { "clang-format" },
				cpp = { "clang-format" },
				rust = { "rustfmt" },

				-- Python
				python = { "isort", "black" },

				-- Lua & Shell
				lua = { "stylua" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
