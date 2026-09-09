return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			return {
				ensure_installed = {
					-- Frontend & JS/TS
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",

					-- PHP / Laravel
					"intelephense",

					-- Systems & Compiled
					"clangd",
					"rust_analyzer",

					-- Python
					"pyright",

					-- Lua & Neovim
					"lua_ls",

					-- DevOps & Systems
					"bashls",
					"dockerls",
					"yamlls",
				},
				handlers = {
					-- Default handler for all installed servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			}
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- Formatters
				"prettier", -- Web / JS / TS / CSS / JSON / Markdown
				"stylua", -- Lua
				"isort", -- Python imports
				"black", -- Python code formatting
				"clang-format", -- C / C++ formatting
				"pint", -- Laravel PHP code style

				-- Linters
				"pylint", -- Python
				"eslint_d", -- JS / TS
				"php-cs-fixer", -- PHP linting
				"shellcheck", -- Shell script linting
				"cpplint",
				"yamllint",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
