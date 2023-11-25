local grp = augroup("lsp")

autocmd(
	"LspAttach", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
			vim.diagnostic.config({virtual_text=false})
			map("n", "<Leader><C-l>"  , vim.diagnostic.reset)
			map("n", "<Leader>e"      , vim.diagnostic.open_float)
			map("n", "<Leader>[e"     , vim.diagnostic.goto_prev)
			map("n", "<Leader>]e"     , vim.diagnostic.goto_next)
			map("n", "<Leader>D"      , vim.diagnostic.setloclist)
			map("n", "gd"             , vim.lsp.buf.definition)
			map("n", "gD"             , vim.lsp.buf.declaration)
			map("n", "<Space>"        , vim.lsp.buf.hover)
			map("n", "<Leader><Space>", vim.lsp.buf.signature_help)
			map("n", "<Leader>.<Space>", vim.lsp.buf.code_action)
			map("n", "<Leader>r"      , vim.lsp.buf.references)
			map("n", "<Leader>R"      , vim.lsp.buf.rename)
		end,
	}
)

autocmd(
	"BufEnter", {
		pattern = "*",
		group = grp,
		callback = function()
			if vim.g.project_mode and vim.g.active_lsp_config then
				vim.b.active_lsp_client = vim.lsp.start(vim.g.active_lsp_config)
			end
		end,
	}
)

autocmd(
	"DiagnosticChanged", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.diagnostic.setloclist({open=false})
		end,
	}
)

autocmd(
	"ColorScheme", {
		pattern = "*",
		group = grp,
		callback = function()
			vim.cmd.highlight({
				"MyProjectMode",
				"ctermfg=7", "ctermbg=6", "cterm=bold",
				"guifg=White", "guibg=DarkCyan", "gui=bold",
			})
			vim.cmd.highlight({
				"MyStatusBarWarn",
				"ctermfg=3", "ctermbg=3", "cterm=bold",
				"guifg=Orange", "guibg=#4b2800", "gui=bold",
			})
			vim.cmd.highlight({
				"MyStatusBarError",
				"ctermfg=1", "ctermbg=1", "cterm=bold",
				"guifg=Red", "guibg=#4b0000", "gui=bold",
			})
		end,
	}
)
