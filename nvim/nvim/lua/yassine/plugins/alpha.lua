return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Full SGA / Elder Futhark Glyph set + extra blanks for sparse floating effects
		local glyphs = {
			"ᚠ",
			"ᛖ",
			"ᛗ",
			"ᛚ",
			"ᛞ",
			"ᚢ",
			"ᚱ",
			"ᚳ",
			"ᚷ",
			"ᚹ",
			"ᚻ",
			"ᚾ",
			"ᛁ",
			"ᛃ",
			"ᛇ",
			"ᛈ",
			"ᛉ",
			"ᛋ",
			"ᛏ",
			"ᛒ",
			"ᛜ",
			"ᛟ",
			"ᛞ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
		}

		-- Highlight color rotation for a subtle glowing aura
		local magic_hls = { "Keyword", "Function", "String", "Identifier", "Type", "Special" }

		local function random_glyph()
			return glyphs[math.random(#glyphs)]
		end

		-- Generates an unrestricted, completely random 6x12 particle field
		local function get_random_particles()
			local lines = {}
			table.insert(lines, "                                                       ")
			for _ = 1, 6 do
				local line = "    "
				for _ = 1, 12 do
					line = line .. random_glyph() .. "   "
				end
				table.insert(lines, line)
			end
			table.insert(lines, "                                                       ")
			return lines
		end

		dashboard.section.header.val = get_random_particles()
		dashboard.section.header.opts.hl = "Special"

		-- Menu buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		alpha.setup(dashboard.opts)

		-- Timer set to 600ms for a slow, ambient particle shift
		local timer = vim.uv.new_timer()
		timer:start(
			0,
			600,
			vim.schedule_wrap(function()
				local buf = vim.api.nvim_get_current_buf()
				if vim.bo[buf].filetype == "alpha" then
					dashboard.section.header.val = get_random_particles()
					dashboard.section.header.opts.hl = magic_hls[math.random(#magic_hls)]
					alpha.redraw()
				else
					timer:stop()
					if not timer:is_closing() then
						timer:close()
					end
				end
			end)
		)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
