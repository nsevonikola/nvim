return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	build = "make BUILD_FROM_SOURCE=true", -- important: downloads avante_templates / tokenizers
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		-- main provider Avante should use
		provider = "claude",
		-- make sure summary etc. also use Claude, not OpenAI (optional but nice)
		memory_summary_provider = "claude",

		-- Configure keybindings for chat submission
		mappings = {
			submit = {
				normal = "<CR>",
				insert = "<C-CR>",
			},
			-- Optional: Add other useful mappings
			ask = "<leader>aa",
			edit = "<leader>ae",
			refresh = "<leader>ar",
		},

		-- NEW: provider configs live here now (per migration guide)
		-- all Claude-specific options must be under providers.claude
		providers = {
			claude = {
				api_key = os.getenv("ANTHROPIC_API_KEY"),
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514", -- "claude-sonnet-4-6", -- doesnt work currently with avante
				timeout = 30000,
				extra_request_body = {
					temperature = 0.2,
				}, -- if you want to override defaults
				-- extra_request_body = { max_tokens = 4096 }, -- if you want to override defaults
				--
			},

			-- explicitly disable OpenAI if you don’t want accidental calls
			openai = nil,
		},
	},
}
