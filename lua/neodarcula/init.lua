-- Define the neodarcula colorscheme
local neodarcula = {}

neodarcula.colors = {
	fg = "#A9B7C6", -- General text
	bg = "#1B1B1B",
	selection = "#214283", -- Selection background (more blue)
	current_line = "#323232", -- Current line highlight
	string = "#6A8759", -- Strings
	number = "#6897BB", -- Numbers
	keyword = "#CC7832", -- Keywords (e.g., public, class, implements, enum)
	comment = "#808080", -- Comments
	constant = "#9876AA", -- Constants
	type = "#CC7832", -- Types (used sparingly, not for enum/class names)
	func = "#6897BB", -- Functions/Methods/Constructors declaration (blue)
	operator = "#A9B7C6", -- Operators (matches foreground)
	error = "#BC3F3C", -- Errors
	warning = "#A9A557", -- Warnings
	info = "#606060", -- Info
	hint = "#606060", -- Hints (same as info in Darcula)
	gray = "#606366", -- UI elements like LineNr
	annotation = "#BBB529", -- Annotations (e.g., @Component)
	variable = "#9876AA", -- Class/instance/static variables (pinkish-purple)
	search_bg = "#22535E", -- Other matches
	inc_search_bg = "#00006B", -- During active search
	cur_search_bg = "#00006B", -- Current match after search
	flash_label_bg = "#FF007F", -- Flash.nvim label background
	eyeliner_bg = "#000000", -- eyeliner.nvim background
	eyeliner_fg = "#FFFFFF", -- eyeliner.nvim background
}

-- Default configuration
local default_config = {
	transparent = false,
}

neodarcula.config = default_config

-- Function to setup configuration
function neodarcula.setup(opts)
	neodarcula.config = vim.tbl_extend("force", default_config, opts or {})
end

function neodarcula.apply()
	local colors = neodarcula.colors
	local cfg = neodarcula.config

	local bg = colors.bg
	if cfg.transparent then
		---@diagnostic disable-next-line: cast-local-type
		bg = nil
	end

	-- Apply highlights
	vim.api.nvim_set_hl(0, "Normal", {
		fg = colors.fg,
		bg = bg,
	})
	vim.api.nvim_set_hl(0, "NormalFloat", {
		fg = colors.fg,
		bg = bg,
	})
	vim.api.nvim_set_hl(0, "Visual", { bg = colors.selection })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.current_line })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.current_line })
	vim.api.nvim_set_hl(0, "LineNr", {
		fg = colors.gray,
		bg = bg,
	})
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.fg, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.gray, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "VertSplit", {
		fg = colors.gray,
		bg = bg,
	})
	vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.selection })
	vim.api.nvim_set_hl(0, "Search", { bg = colors.search_bg, fg = colors.fg, bold = false })
	vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.inc_search_bg, fg = colors.fg, bold = true })
	vim.api.nvim_set_hl(0, "CurSearch", { bg = colors.cur_search_bg, fg = colors.fg, bold = true })

	-- Syntax highlighting (fallback)
	vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment, italic = true })
	vim.api.nvim_set_hl(0, "String", { fg = colors.string })
	vim.api.nvim_set_hl(0, "Number", { fg = colors.number })
	vim.api.nvim_set_hl(0, "Keyword", { fg = colors.keyword })
	vim.api.nvim_set_hl(0, "Constant", { fg = colors.constant })
	vim.api.nvim_set_hl(0, "Type", { fg = colors.type })
	vim.api.nvim_set_hl(0, "Function", { fg = colors.func })
	vim.api.nvim_set_hl(0, "Operator", { fg = colors.operator })
	vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg })

	-- Diagnostics (LSP)
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.warning })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.info })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.hint })

	-- Treesitter integration (fallback)
	vim.api.nvim_set_hl(0, "@keyword", { fg = colors.keyword })
	vim.api.nvim_set_hl(0, "@keyword.import", { fg = colors.keyword })
	vim.api.nvim_set_hl(0, "@namespace", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "@string", { fg = colors.string })
	vim.api.nvim_set_hl(0, "@number", { fg = colors.number })
	vim.api.nvim_set_hl(0, "@function", { fg = colors.func })
	vim.api.nvim_set_hl(0, "@function.call", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "@variable", { fg = colors.variable })
	vim.api.nvim_set_hl(0, "@comment", { fg = colors.comment, italic = true })
	vim.api.nvim_set_hl(0, "@type", { fg = colors.type })
	vim.api.nvim_set_hl(0, "@constant", { fg = colors.constant })
	vim.api.nvim_set_hl(0, "@attribute", { fg = colors.annotation })

	-- LSP Semantic Tokens
	vim.api.nvim_set_hl(0, "@lsp.type.keyword", { fg = colors.keyword }) -- e.g., public, class, implements, enum
	vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = colors.fg }) -- Package paths
	vim.api.nvim_set_hl(0, "@lsp.type.class", { fg = colors.fg }) -- Class names
	vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = colors.fg }) -- Interface names
	vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = colors.fg }) -- Enum names (e.g., InventoryError)
	vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = colors.fg }) -- Default for all methods
	vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = colors.fg }) -- Function/method calls
	vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = colors.fg }) -- Variables (general)
	vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = colors.variable }) -- Class/instance/static fields
	vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = colors.fg }) -- Parameters
	vim.api.nvim_set_hl(0, "@lsp.type.constant", { fg = colors.constant })
	vim.api.nvim_set_hl(0, "@lsp.type.string", { fg = colors.string })
	vim.api.nvim_set_hl(0, "@lsp.type.number", { fg = colors.number })
	vim.api.nvim_set_hl(0, "@lsp.type.operator", { fg = colors.operator })
	vim.api.nvim_set_hl(0, "@lsp.type.annotation", { fg = colors.annotation })
	vim.api.nvim_set_hl(0, "@lsp.mod.annotation", { fg = colors.annotation })
	vim.api.nvim_set_hl(0, "@lsp.typemod.method.declaration", { fg = colors.func }) -- Method declarations
	vim.api.nvim_set_hl(0, "@lsp.typemod.enum.constructor", { fg = colors.func }) -- Enum constructors (blue)
	vim.api.nvim_set_hl(0, "@lsp.mod.constructor", { fg = colors.func }) -- General constructors (blue)

	-- Telescope integration
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.gray, bg = colors.bg })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.fg, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = colors.fg, bg = colors.current_line })
	vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = colors.fg })
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg })
	vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.selection })

	-- Flash.nvim
	vim.api.nvim_set_hl(0, "FlashLabel", {
		fg = colors.flash_label_bg,
		bg = bg,
		bold = true,
	})

	-- eyeliner.nvim
	vim.api.nvim_set_hl(
		0,
		"EyelinerPrimary",
		{ fg = colors.eyeliner_fg, bg = colors.eyeliner_bg, bold = true, underline = false }
	)
	vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = colors.eyeliner_fg, bg = colors.eyeliner_bg, underline = false })
end

return neodarcula
