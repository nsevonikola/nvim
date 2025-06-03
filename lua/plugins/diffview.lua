local function toggle_diffview(cmd)
	if next(require("diffview.lib").views) == nil then
		vim.cmd(cmd)
	else
		vim.cmd("DiffviewClose")
	end
end

return {
	"sindrets/diffview.nvim",
	command = "DiffviewOpen",
	config = function()
		require("diffview").setup({
			view = {
				-- Define the layout for the diff view
				default = {
					layout = "diff2_horizontal", -- Options: "diff2_horizontal", "diff2_vertical", "diff3_horizontal", "diff3_vertical", "diff4_mixed"
				},
				merge_tool = {
					layout = "diff3_vertical", -- Layout for merge conflicts
					disable_diagnostics = true, -- Disable diagnostics in the merge tool
				},
				file_history = {
					layout = "diff2_horizontal", -- Layout for file history
				},
			},
		})
	end,
	keys = {
		{
			"<leader>gd",
			function()
				toggle_diffview("DiffviewOpen")
			end,
			desc = "[d]iff index",
		},
		{
			"<leader>gD",
			function()
				toggle_diffview("DiffviewOpen master..HEAD")
			end,
			desc = "[D]iff master",
		},
		{
			"<leader>gf",
			function()
				toggle_diffview("DiffviewFileHistory %")
			end,
			desc = "Diffs for current [F]ile",
		},
		{
			"<leader>gL",
			function()
				local word = vim.fn.expand("<cword>")
				local file = vim.fn.expand("%:p")
				local cmd = "DiffviewFileHistory -L:" .. word .. ":" .. file
				toggle_diffview(cmd)
			end,
			desc = "Diff history for current [L]ine",
		},
	},
}
