-- Run Claude Code in a real kitty window (split next to Neovim) instead of a
-- Neovim terminal buffer.
--
-- Why not `provider = "external"`: that provider shells out with `jobstart(...,
-- env = env_table)`, but `kitty @ launch` is only a remote-control *client* --
-- the new window's process is spawned by the kitty daemon and inherits *its*
-- environment, so CLAUDE_CODE_SSE_PORT / ENABLE_IDE_INTEGRATION never reach
-- claude and the IDE integration (diffs, @-mentions, selection sending) stays
-- dead. It also tracks state via the client's job id, which exits immediately
-- after launching, so close/toggle/focus never find the window again.
--
-- This custom provider passes the env through `kitty @ launch --env` and tags
-- the window with `--var claudecode_nvim=<nvim pid>` so it can be matched later
-- for focus/close. If Neovim is not running inside kitty, `is_available()`
-- returns false and the plugin falls back to its own `native` terminal.

local kitty = {}

---@type table Terminal config handed over by claudecode.terminal.setup()
local term_config = {}

---Kitty-specific knobs, read from `terminal.provider_opts.kitty`.
local function opts()
  return (term_config.provider_opts and term_config.provider_opts.kitty) or {}
end

---Runs `kitty @ <args>` synchronously.
---@param args string[]
---@param quiet boolean? Don't notify on failure (used for existence probes)
---@return boolean ok
---@return vim.SystemCompleted result
local function rc(args, quiet)
  local cmd = { "kitty", "@" }
  vim.list_extend(cmd, args)
  local res = vim.system(cmd, { text = true }):wait(5000)
  if res.code ~= 0 and not quiet then
    vim.notify(
      "claudecode kitty: `" .. table.concat(cmd, " ") .. "` failed: " .. ((res.stderr or ""):gsub("%s+$", "")),
      vim.log.levels.ERROR
    )
  end
  return res.code == 0, res
end

---Unique marker for the window owned by *this* Neovim instance.
local function match()
  return "var:claudecode_nvim=" .. vim.fn.getpid()
end

local function exists()
  return (rc({ "ls", "--match", match() }, true))
end

local function claude_focused()
  return (rc({ "ls", "--match", match() .. " and state:focused" }, true))
end

local function focus_claude()
  return (rc({ "focus-window", "--match", match() }))
end

local function focus_editor()
  local id = vim.env.KITTY_WINDOW_ID
  if not id then
    return false
  end
  return (rc({ "focus-window", "--match", "id:" .. id }))
end

---@param cmd_string string e.g. "claude --resume"
---@param env_table table Env claude needs to find this Neovim's websocket server
---@param effective_config table
---@param focus boolean?
local function launch(cmd_string, env_table, effective_config, focus)
  local o = opts()
  local self_id = vim.env.KITTY_WINDOW_ID
  local cwd = (effective_config and effective_config.cwd) or vim.fn.getcwd()

  local args = {
    "launch",
    "--type=window",
    "--location=" .. (o.location or "vsplit"),
    "--cwd",
    cwd,
    "--var",
    "claudecode_nvim=" .. vim.fn.getpid(),
    "--title",
    o.title or ("Claude " .. vim.fn.fnamemodify(cwd, ":t")),
  }
  if o.bias then
    -- Percentage of the split the new window gets (see `kitty @ launch --bias`).
    vim.list_extend(args, { "--bias", tostring(o.bias) })
  end
  if self_id then
    -- Put it in Neovim's tab (--match selects the *tab* for launch) and next to
    -- Neovim's window, so it lands correctly even if another tab is active.
    vim.list_extend(args, { "--match", "window_id:" .. self_id, "--next-to", "id:" .. self_id })
  end
  if focus == false then
    table.insert(args, "--dont-take-focus")
  end

  -- The whole point: hand the IDE-integration env to the child explicitly.
  for k, v in pairs(env_table or {}) do
    vim.list_extend(args, { "--env", k .. "=" .. tostring(v) })
  end
  -- kitty's daemon env may predate the PATH your shell sets up (claude lives in
  -- ~/.local/bin here), so resolve it exactly as Neovim sees it.
  vim.list_extend(args, { "--env", "PATH=" .. (vim.env.PATH or "") })

  vim.list_extend(args, { "sh", "-c", cmd_string })
  rc(args)
end

function kitty.setup(config)
  term_config = config or {}
end

function kitty.open(cmd_string, env_table, effective_config, focus)
  if exists() then
    if focus ~= false then
      focus_claude()
    end
  else
    launch(cmd_string, env_table, effective_config, focus)
  end
end

function kitty.close()
  if exists() then
    rc({ "close-window", "--match", match() })
  end
end

-- Kitty splits can't be hidden without killing the session, so toggling means
-- "jump to Claude / jump back to Neovim". Use :ClaudeCodeClose to end it.
function kitty.simple_toggle(cmd_string, env_table, effective_config)
  if not exists() then
    launch(cmd_string, env_table, effective_config, true)
  elseif claude_focused() then
    focus_editor()
  else
    focus_claude()
  end
end

kitty.focus_toggle = kitty.simple_toggle

-- A kitty split is always visible when it exists, so there is nothing to do.
function kitty.ensure_visible() end

-- Claude runs outside Neovim, so there is no terminal buffer. Returning nil
-- also keeps the diff code from treating a Neovim window as the Claude pane.
function kitty.get_active_bufnr()
  return nil
end

function kitty.is_available()
  return vim.fn.executable("kitty") == 1 and (vim.env.KITTY_LISTEN_ON ~= nil or vim.env.KITTY_WINDOW_ID ~= nil)
end

return {
  "coder/claudecode.nvim",
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  opts = {
    -- Jump to the kitty window after sending a selection/file, so you can type
    -- the prompt right away. Set to false to keep focus in Neovim.
    focus_after_send = true,
    terminal = {
      provider = kitty,
      provider_opts = {
        kitty = {
          location = "vsplit", -- any `kitty @ launch --location` value
          -- bias = 40,        -- % of the split width given to Claude
          -- title = "Claude", -- defaults to "Claude <project dir>"
        },
      },
    },
  },
}
