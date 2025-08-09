-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mts",
	command = "set filetype=typescript",
})
-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function(event)
		print(string.format("starting hyprls for %s", vim.inspect(event)))
		vim.lsp.start({
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		})
	end,
})

local function parse_biome_github_output(filter)
	local output = vim.fn.systemlist("npm run lint -- --reporter=github")
	local qf_entries = {}

	for _, line in ipairs(output) do
		local level, file, lnum, col, message =
			string.match(line, [[::(%a+)%s+title=.-,file=([^,]+),line=(%d+),.-col=(%d+),.-::(.*)]])

		if file and lnum and col and message then
			-- Jeśli podany filtr jest ustawiony i obecny level go nie spełnia — pomiń
			if not filter or filter[level] then
				local qf_type = ({
					error = "E",
					warning = "W",
					info = "I",
					notice = "I",
				})[level] or "E"

				table.insert(qf_entries, {
					filename = file,
					lnum = tonumber(lnum),
					col = tonumber(col),
					text = message,
					type = qf_type,
				})
			end
		end
	end

	if #qf_entries == 0 then
		vim.notify("Biome: no matching diagnostics found", vim.log.levels.INFO)
	else
		vim.fn.setqflist(qf_entries, "r")
		vim.cmd("copen")
	end
end

vim.api.nvim_create_user_command("BiomeLintAll", function()
	parse_biome_github_output(nil)
end, {})

vim.api.nvim_create_user_command("BiomeLintErrors", function()
	parse_biome_github_output({ error = true })
end, {})

vim.keymap.set("n", "<leader>bl", ":BiomeLintAll<CR>", { desc = "Biome Lint (all)" })
vim.keymap.set("n", "<leader>be", ":BiomeLintErrors<CR>", { desc = "Biome Lint (errors only)" })
