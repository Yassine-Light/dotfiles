return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local api = require("nvim-tree.api")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Custom creation function that prompts only once
		local function create_relative()
			local node = api.tree.get_node_under_cursor()
			local target_dir
			if node and node.type == "directory" then
				target_dir = node.absolute_path
			elseif node and node.parent then
				target_dir = node.parent.absolute_path
			else
				target_dir = vim.fn.getcwd()
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

				-- If path ends with "/", create a directory; otherwise create a file
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

		local function my_on_attach(bufnr)
			local opts = function(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			-- Override 'a' to use single relative prompt
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
				ignore = false,
			},
		})
	end,
}
