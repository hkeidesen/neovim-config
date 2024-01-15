return {
	"wakatime/vim-wakatime",
	--	events = { "VimEnter" },
	config = function()
		event = "BufReadPost"
		vim.g.wakatime_project = "wakatime"
	end,
}
