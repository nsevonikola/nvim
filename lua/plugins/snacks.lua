SnacksPickerLayout = {
	layout = {
		width = 0.6,
		min_width = 80,
		height = 0.8,
		min_height = 30,
		box = "vertical",
		border = "rounded",
		title = "{title} {live} {flags}",
		title_pos = "center",
		{ win = "input", height = 1, border = "bottom" },
		{ win = "list", border = "none" },
		{ win = "preview", title = "{preview}", height = 0.7, border = "top" },
	},
}

local function get_last_n_sections(path, n)
	local sections = {}
	for section in string.gmatch(path, "[^/\\]+") do
		table.insert(sections, section)
	end
	local start_index = math.max(#sections - n + 1, 1)
	return table.concat(sections, "/", start_index)
end

-- Formatter
function SnacksFormatter(item)
	local devicons = require("nvim-web-devicons")
	local icon, icon_hl = devicons.get_icon(item.file, vim.fn.fnamemodify(item.file, ":e"))
	-- Custom formatter showing index
	local path_1 = vim.fn.fnamemodify(item.file, ":h")
	local path_2 = get_last_n_sections(vim.fn.fnamemodify(item.file, ":h"), 6)
	local shortest_path = #path_1 < #path_2 and path_1 or path_2
	return {
		{ icon and (icon .. " ") or "", icon_hl },
		{ vim.fn.fnamemodify(item.file, ":t"), "String" },
		{ " " .. shortest_path, "Comment" },
	}
end

-- nvim v0.8.0
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		explorer = {},
		notifier = {
			enabled = true,
		},
		picker = {
			enabled = true,
		},
		matcher = {
			fuzzy = true, -- use fuzzy matching
			smartcase = true, -- use smartcase
			ignorecase = true, -- use ignorecase
			sort_empty = false, -- sort results when the search string is empty
			filename_bonus = true, -- give bonus for matching file names (last part of the path)
			file_pos = true, -- support patterns like `file:line:col` and `file:line`
			-- the bonusses below, possibly require string concatenation and path normalization,
			-- so this can have a performance impact for large lists and increase memory usage
			cwd_bonus = false, -- give bonus for matching files in the cwd
			frecency = true, -- frecency bonus
		},
		-- animate = { enabled = true },
		dashboard = {
			enabled = true,
		},
	},
	keys = {
		-- Buffers
		{
			"<leader><space>",
			function()
				Snacks.picker.buffers({
					-- I always want my buffers picker to start in normal mode
					on_show = function()
						vim.cmd.stopinsert()
					end,
					layout = SnacksPickerLayout,
					finder = "buffers",
					format = SnacksFormatter,
					hidden = false,
					unloaded = true,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["d"] = "bufdelete",
							},
						},
						list = { keys = { ["d"] = "bufdelete" } },
					},
					-- In case you want to override the layout for this keymap
					-- layout = "ivy",
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		-- Find
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<C-p>",
			function()
				Snacks.picker.files({
					format = SnacksFormatter,
					layout = SnacksPickerLayout,
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>ee",
			function()
				Snacks.explorer.open()
			end,
			desc = "Explore Files",
		},
		{
			"<leader>eb",
			function()
				Snacks.explorer.open()
			end,
			desc = "Explore Buffers",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- {
		-- 	"<leader>c",
		-- 	function()
		-- 		Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		-- 	end,
		-- 	desc = "Find Config File",
		-- },
		-- {
		-- 	"<leader>fg",
		-- 	function()
		-- 		Snacks.picker.git_files()
		-- 	end,
		-- 	desc = "Find Git Files",
		-- },
		-- git
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log({
					finder = "git_log",
					format = "git_log",
					preview = "git_show",
					confirm = "git_checkout",
					layout = "vertical",
				})
			end,
			desc = "Git Log",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "[G]it [S]tatus",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches({ layout = "select" })
			end,
			desc = "[G]it [B]ranches",
		},

		-- Grep
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},

		-- Search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps({
					layout = "vertical",
				})
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>qp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		-- Notifier
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history(opts)
			end,
			desc = "[Notify] History",
		},
	},
}
