return {
	"yetone/avante.nvim",
	event = "VeryLazy",
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

		-- NEW: provider configs live here now (per migration guide)
		-- all Claude-specific options must be under providers.claude
		providers = {
			claude = {
				api_key = os.getenv("ANTHROPIC_API_KEY"),
				endpoint = "https://api.anthropic.com",
				model = "claude-4.6-sonnet", -- your chosen Sonnet model id
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
