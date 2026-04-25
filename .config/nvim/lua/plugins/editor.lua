return {
  -- Telescope: VSCode-like prompt position
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- neo-tree: show hidden files, git status icons
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
      },
      window = {
        width = 35,
        mappings = {
          -- familiar VSCode-like expand/collapse
          ["<space>"] = "toggle_node",
        },
      },
    },
  },

  -- Mason: skip tools managed by Homebrew
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not vim.tbl_contains({ "ruff" }, tool)
      end, opts.ensure_installed or {})
    end,
  },

  -- Treesitter: languages to install upfront
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "tsx",
        "typescript",
        "yaml",
      })
    end,
  },
}
