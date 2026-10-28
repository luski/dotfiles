local vitest_config_by_path = {
  -- Add folder-to-config mappings here (first match wins).
  -- Example:
  { folder = "test/integration", config = "test/integration/vitest.config.ts" },
  { folder = "sf-gui", config = "test/unit/vitest.config.ts" },
}

-- Fixed project root for vitest execution.
local project_root = vim.fn.expand("~/projects/sf/sf-gui")

local function resolve_vitest_config(file_path)
  if not file_path or file_path == "" then
    return "vitest.config.ts"
  end

  for _, mapping in ipairs(vitest_config_by_path) do
    if file_path:find(mapping.folder, 1, true) then
      return mapping.config
    end
  end

  return "vitest.config.ts"
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      ["neotest-vitest"] = {
        cwd = function()
          return project_root
        end,
        vitestConfigFile = function(file_path)
          return resolve_vitest_config(file_path)
        end,
      },
    },
  },
}
