return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			-- 1. Tell conform how to run c_formatter_42
			formatters = {
				c_formatter_42 = {
					command = "c_formatter_42",
					args = { "$FILENAME" },
					stdin = false,
				},
			},

			-- 2. Map it to C files
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
				c = { "c_formatter_42" },
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
				lsp_fallback = false, -- Set to false so clangd doesn't override it
				async = false,
				timeout_ms = 3000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
