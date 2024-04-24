return{
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = { vim.fn.stdpath("config") .. "/snippets" },
	}),
	print("Loading snippets from: " .. vim.fn.stdpath("config") .. "/snippets")
}