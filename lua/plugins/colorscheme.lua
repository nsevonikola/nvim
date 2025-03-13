return {
	"catppuccin/nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			default_integrations = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				which_key = true,
				noice = true,
				snacks = {
					enabled = true,
					indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
				},
				-- nvim-lspconfig
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				-- For more plugins integrations (https://github.com/catppuccin/nvim#integrations)
			},
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					TabLineSel = { bg = colors.pink },
					CmpBorder = { fg = colors.surface2 },
					Pmenu = { bg = colors.none },
					Operator = { fg = colors.pink },
					["@keyword.export"] = {
						fg = colors.red,
					},
					["@tag.attribute.tsx"] = {
						cterm = {
							italic = true,
						},
						fg = "#a6adc8",
						italic = true,
					},
					["@tag.delimiter"] = {
						fg = "#f9e2af",
					},
				}
			end,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("kanagawa").setup({
-- 			compile = false, -- enable compiling the colorscheme
-- 			undercurl = true, -- enable undercurls
-- 			commentStyle = { italic = true },
-- 			functionStyle = {},
-- 			keywordStyle = { italic = true },
-- 			statementStyle = { bold = true },
-- 			typeStyle = {},
-- 			transparent = false, -- do not set background color
-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
-- 			-- colors = { -- add/modify theme and palette colors
-- 			-- 	palette = {},
-- 			-- 	theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
-- 			-- },
-- 			overrides = function(colors) -- add/modify highlights
-- 				return {}
-- 			end,
-- 			theme = "wave", -- Load "wave" theme when 'background' option is not set
-- 			colors = {
-- 				theme = { all = { ui = { bg_gutter = "none" } } },
-- 			},
-- 			background = { -- map the value of 'background' option to a theme
-- 				dark = "wave", -- try "dragon" !
-- 				light = "lotus",
-- 			},
-- 		})
--
-- 		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1a1a21" })
-- 		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#1a1a21" })
-- 		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#d4c9b2" }) -- Directory names
-- 		vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#b8b8b8" }) -- Directory icons
-- 		vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#b8b8b8" })    -- File names
-- 		vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#b8b8b8" })    -- File icons
-- 		vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#54546d" }) -- Indent markers
-- 		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#98bb6c" })    -- Git added files
-- 		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#7fb4ca" }) -- Git modified files
-- 		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#e46876" })  -- Git deleted files
--
-- 		vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE", fg = "NONE" }) -- Make the vertical split line transparent
--
-- 		vim.cmd("colorscheme kanagawa-wave")
-- 	end,
-- }
