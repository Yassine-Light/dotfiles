return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Unified file/folder creation logic
		local function create_relative()
			local target_dir

			-- If inside nvim-tree, determine directory from node under cursor
			if vim.bo.filetype == "NvimTree" then
				local node = api.tree.get_node_under_cursor()
				if node and node.type == "directory" then
					target_dir = node.absolute_path
				elseif node and node.parent then
					target_dir = node.parent.absolute_path
				else
					target_dir = vim.fn.getcwd()
				end
			else
				-- Otherwise use current buffer's directory or cwd
				local current_file = vim.api.nvim_buf_get_name(0)
				if current_file ~= "" then
					target_dir = vim.fs.dirname(current_file)
				else
					target_dir = vim.fn.getcwd()
				end
			end

			local rel_path = vim.fn.fnamemodify(target_dir, ":.") .. "/"

			vim.ui.input({
				prompt = "Create file/folder: ",
				default = rel_path,
			}, function(input)
				if not input or #input == 0 then
					return
				end

				local full_path = vim.fn.fnamemodify(input, ":p")

				-- Directory if ends with "/", else file
				if input:sub(-1) == "/" then
					vim.fn.mkdir(full_path, "p")
				else
					local dir = vim.fs.dirname(full_path)
					if vim.fn.isdirectory(dir) == 0 then
						vim.fn.mkdir(dir, "p")
					end
					local file = io.open(full_path, "w")
					if file then
						file:close()
						vim.cmd("edit " .. vim.fn.fnameescape(full_path))
					end
				end

				api.tree.reload()
			end)
		end

		-- Global Keymaps
		local keymap = vim.keymap
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
		keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus file explorer on active file" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

		-- Global shortcut to prompt file creation anywhere
		keymap.set("n", "<leader>fn", create_relative, { desc = "Create file/folder (relative)" })

		local function my_on_attach(bufnr)
			local opts = function(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			-- Override 'a' inside tree
			vim.keymap.set("n", "a", create_relative, opts("Create (Relative Path)"))
		end

		nvimtree.setup({
			on_attach = my_on_attach,
			view = {
				width = 50,
				relativenumber = true,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					show = {
						git = false,
					},
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				enable = false,
				ignore = false,
			},
		})
	end,
}
