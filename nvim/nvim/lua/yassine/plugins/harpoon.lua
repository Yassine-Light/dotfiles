return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		-- Setup harpoon
		harpoon:setup()

		-- File Management
		vim.keymap.set("n", "<leader>t", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Add file" })

		vim.keymap.set("n", "<leader>ts", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Toggle menu" })

		-- Quick Navigation (HJKL sequence)
		vim.keymap.set("n", "<leader>th", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: File 1" })

		vim.keymap.set("n", "<leader>tj", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: File 2" })

		vim.keymap.set("n", "<leader>tk", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: File 3" })

		vim.keymap.set("n", "<leader>tl", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: File 4" })

		-- Telescope Integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon Marks",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>tS", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Harpoon: Search marks in Telescope" })
	end,
}
