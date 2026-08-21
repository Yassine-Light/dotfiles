vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Telescope

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })

-- Auto session

keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Helper function to execute shell commands in a given directory
local function run_cmd_in_dir(dir, prompt_title)
	local rel_dir = vim.fn.fnamemodify(dir, ":.")
	if rel_dir == "" then
		rel_dir = "."
	end

	vim.ui.input({
		prompt = prompt_title .. " (" .. rel_dir .. "): ",
	}, function(input)
		if not input or #input == 0 then
			return
		end

		-- Run asynchronously in a Neovim terminal split
		vim.cmd("split | terminal cd " .. vim.fn.shellescape(dir) .. " && " .. input)
	end)
end

-- 1. Run command at project root (cwd)
vim.keymap.set("n", "<leader>cx", function()
	run_cmd_in_dir(vim.fn.getcwd(), "Run Root Cmd")
end, { desc = "Run shell command at project root" })

-- 2. Run command in current file's directory
vim.keymap.set("n", "<leader>cd", function()
	local current_file = vim.api.nvim_buf_get_name(0)
	local target_dir = current_file ~= "" and vim.fs.dirname(current_file) or vim.fn.getcwd()
	run_cmd_in_dir(target_dir, "Run Dir Cmd")
end, { desc = "Run shell command in current file's directory" })
