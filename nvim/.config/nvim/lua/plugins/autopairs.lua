-- https://github.com/windwp/nvim-autopairs
local autopairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

autopairs.setup({
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	disable_in_macro = true,
	disable_in_visualblock = false,
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true,
	enable_check_bracket_line = false,
	enable_bracket_in_quote = true,
	enable_abbr = false,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey="Comment"
	},
	break_undo = true,
	check_ts = true,
	map_cr = true,
	map_bs = true,
	map_c_h = false,
	map_c_w = false,
})
