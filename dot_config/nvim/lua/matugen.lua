 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131315',
    base01 = '#1f1f21',
    base02 = '#2a2a2b',
    base03 = '#909097',
    base04 = '#c6c6cd',
    base05 = '#e4e2e3',
    base06 = '#e4e2e3',
    base07 = '#e4e2e3',
    base08 = '#ffb4ab',
    base09 = '#dbbed2',
    base0A = '#c4c6d0',
    base0B = '#bec6de',
    base0C = '#dbbed2',
    base0D = '#bec6de',
    base0E = '#c4c6d0',
    base0F = '#e0e2ec',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e4e2e3',          bg = '#131315' })
  hi('TelescopeBorder',         { fg = '#909097',             bg = '#131315' })
  hi('TelescopePromptNormal',   { fg = '#e4e2e3',          bg = '#131315' })
  hi('TelescopePromptBorder',   { fg = '#909097',             bg = '#131315' })
  hi('TelescopePromptPrefix',   { fg = '#bec6de',             bg = '#131315' })
  hi('TelescopePromptCounter',  { fg = '#c6c6cd',  bg = '#131315' })
  hi('TelescopePromptTitle',    { fg = '#131315',             bg = '#bec6de' })
  hi('TelescopePreviewTitle',   { fg = '#131315',             bg = '#c4c6d0' })
  hi('TelescopeResultsTitle',   { fg = '#131315',             bg = '#dbbed2' })
  hi('TelescopeSelection',      { fg = '#e4e2e3',          bg = '#2a2a2b' })
  hi('TelescopeSelectionCaret', { fg = '#bec6de',             bg = '#2a2a2b' })
  hi('TelescopeMatching',       { fg = '#bec6de',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e4e2e3',          bg = '#131315' })
  hi('MiniPickBorder',         { fg = '#909097',             bg = '#131315' })
  hi('MiniPickPrompt',   { fg = '#e4e2e3',          bg = '#131315' })
  hi('MiniPickPromptPrefix',   { fg = '#bec6de',             bg = '#131315' })
  hi('MiniPickBorderText',    { fg = '#131315',             bg = '#bec6de' })
  hi('MiniPickMatchCurrent',      { fg = '#e4e2e3',          bg = '#2a2a2b' })
  hi('MiniPickPromptCaret', { fg = '#bec6de',             bg = '#2a2a2b' })
  hi('MiniPickMatchRanges',       { fg = '#bec6de',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
