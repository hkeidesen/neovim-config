-- typescript.nvim archived

return {
--	{ import = "lazyvim.plugins.lang.typescript" },

	{
		"nvim-lspconfig",
		opts = {
			servers = {
				tsserver = {
					settings = {
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
			},
		},
	},
}
