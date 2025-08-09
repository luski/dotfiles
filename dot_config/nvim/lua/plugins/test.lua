return {
	"nvim-neotest/neotest",
	dependencies = {
		"marilari88/neotest-vitest",
	},
	opts = {
		adapters = {
			["neotest-vitest"] = {
				vitestCommand = function(path)
					-- specifically for mosaixx-ui
					if string.find(path, "frontend") then
						return "npx vitest"
					else
						return "vitest"
					end
				end,
			},
		},
	},
}
