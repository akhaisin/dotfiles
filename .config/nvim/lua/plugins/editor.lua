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
        -- Show file previews with bat-like syntax highlighting
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
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
