return {
  { "marilari88/neotest-vitest" },
  {
    "nvim-neotest/neotest",
    dependencies = { "preservim/vimux" },
    opts = { adapters = { "neotest-vitest" } },
  },
}
