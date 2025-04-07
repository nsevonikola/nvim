return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "enter",
			["Esc"] = { "hide" },
			["<C-Space>"] = { "show" },
			["<C-c>"] = { "show" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = { auto_show = false },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

-- return { -- Autocompletion
--   "hrsh7th/nvim-cmp",
--   -- event = 'InsertEnter',
--   dependencies = {
--     -- Snippet Engine & its associated nvim-cmp source
--     {
--       "L3MON4D3/LuaSnip",
--       build = (function()
--         -- Build Step is needed for regex support in snippets
--         -- This step is not supported in many windows environments
--         -- Remove the below condition to re-enable on windows
--         if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--           return
--         end
--         return "make install_jsregexp"
--       end)(),
--     },
--     "saadparwaiz1/cmp_luasnip",
--
--     -- Adds other completion capabilities.
--     --  nvim-cmp does not ship with all sources by default. They are split
--     --  into multiple repos for maintenance purposes.
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--
--     -- Adds a number of user-friendly snippets
--     "rafamadriz/friendly-snippets",
--   },
--   config = function()
--     local cmp = require("cmp")
--     require("luasnip.loaders.from_vscode").lazy_load()
--     local luasnip = require("luasnip")
--     luasnip.config.setup({})
--
--     local kind_icons = {
--       Text = "󰉿",
--       Method = "m",
--       Function = "󰊕",
--       Constructor = "",
--       Field = "",
--       Variable = "󰆧",
--       Class = "󰌗",
--       Interface = "",
--       Module = "",
--       Property = "",
--       Unit = "",
--       Value = "󰎠",
--       Enum = "",
--       Keyword = "󰌋",
--       Snippet = "",
--       Color = "󰏘",
--       File = "󰈙",
--       Reference = "",
--       Folder = "󰉋",
--       EnumMember = "",
--       Constant = "󰇽",
--       Struct = "",
--       Event = "",
--       Operator = "󰆕",
--       TypeParameter = "󰊄",
--     }
--
--     cmp.setup({
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       completion = { completeopt = "menu,menuone,noinsert" },
--       -- window = {
--       --     completion = cmp.config.window.bordered(),
--       --     documentation = cmp.config.window.bordered(),
--       -- },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-j>"] = cmp.mapping.select_next_item(),    -- Select the [n]ext item
--         ["<C-k>"] = cmp.mapping.select_prev_item(),    -- Select the [p]revious item
--         ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept the completion with Enter.
--         ["<C-c>"] = cmp.mapping.complete({}),          -- Manually trigger a completion from nvim-cmp.
--
--         -- Think of <c-l> as moving to the right of your snippet expansion.
--         --  So if you have a snippet that's like:
--         --  function $name($args)
--         --    $body
--         --  end
--         --
--         -- <c-l> will move you to the right of each of the expansion locations.
--         -- <c-h> is similar, except moving you backwards.
--         ["<C-l>"] = cmp.mapping(function()
--           if luasnip.expand_or_locally_jumpable() then
--             luasnip.expand_or_jump()
--           end
--         end, { "i", "s" }),
--         ["<C-h>"] = cmp.mapping(function()
--           if luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           end
--         end, { "i", "s" }),
--
--         -- Select next/previous item with Tab / Shift + Tab
--         -- ['<Tab>'] = cmp.mapping(function(fallback)
--         --   if cmp.visible() then
--         --     cmp.select_next_item()
--         --   elseif luasnip.expand_or_locally_jumpable() then
--         --     luasnip.expand_or_jump()
--         --   else
--         --     fallback()
--         --   end
--         -- end, { 'i', 's' }),
--         -- ['<S-Tab>'] = cmp.mapping(function(fallback)
--         --   if cmp.visible() then
--         --     cmp.select_prev_item()
--         --   elseif luasnip.locally_jumpable(-1) then
--         --     luasnip.jump(-1)
--         --   else
--         --     fallback()
--         --   end
--         -- end, { 'i', 's' }),
--       }),
--       sources = {
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "buffer" },
--         { name = "path" },
--       },
--       formatting = {
--         fields = { "kind", "abbr", "menu" },
--         format = function(entry, vim_item)
--           -- Kind icons
--           vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
--           -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
--           vim_item.menu = ({
--             nvim_lsp = "[LSP]",
--             luasnip = "[Snippet]",
--             buffer = "[Buffer]",
--             path = "[Path]",
--           })[entry.source.name]
--           return vim_item
--         end,
--       },
--     })
--   end,
-- }
