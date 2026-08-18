return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- Frontend & JS/TS
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			tsx = { "eslint_d" },
			svelte = { "eslint_d" },
			json = { "jsonlint" },

			-- PHP / Laravel
			php = { "phpstan" },

			-- Systems & Shell
			c = { "cpplint" },
			bash = { "shellcheck" },
			sh = { "shellcheck" },
			zsh = { "shellcheck" },

			-- Python
			python = { "pylint" },

			-- DevOps / Markup
			dockerfile = { "hadolint" },
			yaml = { "yamllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Find config file in parent directories
		local function file_in_cwd(file_name)
			local cwd = (vim.uv or vim.loop).cwd()
			local buf_path = vim.api.nvim_buf_get_name(0)
			if buf_path == "" then
				return nil
			end

			return vim.fs.find(file_name, {
				upward = true,
				stop = cwd:match("(.+)/"),
				path = vim.fs.dirname(buf_path),
				type = "file",
			})[1]
		end

		local function remove_linter(linters, linter_name)
			for k, v in ipairs(linters) do
				if v == linter_name then
					table.remove(linters, k)
					break
				end
			end
		end

		local function linter_in_linters(linters, linter_name)
			for _, v in ipairs(linters) do
				if v == linter_name then
					return true
				end
			end
			return false
		end

		local function remove_linter_if_missing_config_file(linters, linter_name, config_files)
			if not linter_in_linters(linters, linter_name) then
				return
			end

			local has_config = false
			for _, cfg in ipairs(config_files) do
				if file_in_cwd(cfg) then
					has_config = true
					break
				end
			end

			if not has_config then
				remove_linter(linters, linter_name)
			end
		end

		local function try_linting()
			local ft_linters = lint.linters_by_ft[vim.bo.filetype]

			if ft_linters then
				-- Copy table so modifications don't permanently erase global mappings
				local linters = vim.deepcopy(ft_linters)

				-- Don't run eslint_d unless a valid ESLint config exists in the project
				remove_linter_if_missing_config_file(linters, "eslint_d", {
					"eslint.config.js",
					"eslint.config.mjs",
					"eslint.config.cjs",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
				})

				lint.try_lint(linters)
			end
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				try_linting()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			try_linting()
		end, { desc = "Trigger linting for current file" })
	end,
}
