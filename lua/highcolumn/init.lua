local M = {}

function M.setup()

	vim.api.nvim_create_user_command("format", function()
		vim.cmd("ggVGgq")
	end, {})

	vim.api.nvim_create_user_command("hideColumn", function()
		local current_number = vim.wo.number
		local current_relativenumber = vim.wo.relativenumber
		local current_signcolumn = vim.wo.signcolumn
		local current_statusline = vim.opt.statusline:get()
		local textwidth = 35

		-- Toggle the settings

		vim.o.textwidth = textwidth
		-- vim.opt.formatoptions = "ta"
		vim.wo.number = not current_number
		vim.wo.relativenumber = not current_relativenumber
		vim.wo.signcolumn = current_signcolumn == "yes" and "no" or "yes"
		vim.wo.fillchars = "eob: "

		-- Toggle the statusline
		if current_statusline == "2" then
			vim.opt.statusline = ""
		else
			vim.opt.statusline = "2"
		end

		-- Disable LSP diagnostics
		vim.diagnostic.disable(0)

		-- If render-markdown plugin is loaded, configure its settings
		if pcall(require, "render-markdown") then
			local render_markdown = require("render-markdown")
			local color1_bg = "#c76b98"
			local color2_bg = "#8feadd"
			local color3_bg = "#6798b0"
			local color4_bg = "#947394"
			local color5_bg = "#f6e2ba"
			local color6_bg = "#f7c67f"
			local color_fg = "#323449"

			-- Heading colors
			vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
			vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
			vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
			vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
			vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
			vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))

			-- Heading and sign icons
			vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
			vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
			vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
			vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
			vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
			vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
			vim.cmd(string.format([[highlight RenderMarkdownDash cterm=bold gui=bold guifg=%s]], color6_bg))
			vim.cmd(string.format([[highlight RenderMarkdownBullet cterm=bold gui=bold guifg=%s]], color6_bg))

			render_markdown.setup({
				heading = {
					sign = false,
					backgrounds = {
						"Headline1Bg",
						"Headline2Bg",
						"Headline3Bg",
						"Headline4Bg",
						"Headline5Bg",
						"Headline6Bg",
					},
					foregrounds = {
						"Headline1Fg",
						"Headline2Fg",
						"Headline3Fg",
						"Headline4Fg",
						"Headline5Fg",
						"Headline6Fg",
					},
				},
				sign = { enabled = false },
			})
		end
	end, {})
end

return M
