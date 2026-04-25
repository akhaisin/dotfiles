return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        timeout = 5000,
        style = "fancy",
        level = vim.log.levels.TRACE,
        override = {
          [vim.log.levels.ERROR] = { timeout = false },
          [vim.log.levels.WARN] = { timeout = false },
        },
      },
    },
  },
}
