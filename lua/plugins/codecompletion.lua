return {
	"IntoTheNull/claude.nvim",
	event = "InsertEnter",
	config = function()
		require("claude").setup({
			providers = {
				claude = {
					api_key = os.getenv("ANTHROPIC_API_KEY"),
					model = "claude-sonnet-4-6",
					completion = {
						enabled = true,
					},
				},
			},
		})

		vim.keymap.set("i", "<C-j>", function()
			require("claude.completion").accept()
		end, { desc = "Accept Claude completion" })
	end,
}
