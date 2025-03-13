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
