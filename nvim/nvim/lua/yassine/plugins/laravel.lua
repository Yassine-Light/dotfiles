return {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Laravel" },
	keys = {
		{ "<leader>la", "<cmd>Laravel artisan<cr>", desc = "Laravel Artisan" },
		{ "<leader>lr", "<cmd>Laravel routes<cr>", desc = "Laravel Routes" },
	},
	opts = {},
}
