return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      -- Attaches to every FileType mode
      require("colorizer").setup()
    end,
  },

  {
    "kkoomen/vim-doge",
    config = function()
      vim.cmd(":call doge#install()")
      vim.keymap.set("n", "<Leader>cg", "::DogeGenerate<CR>")
      vim.g.vdoge_enable_mapping = false
      vim.g.doge_python_settings = {
        single_quotes = false,
        omit_redundant_param_types = false,
      }
      vim.g.doge_doc_standard_python = "google"
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {},
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "stevearc/conform.nvim",

    event = "BufWritePre",

    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          fish = { "fish_indent" },
        },

        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
      })

      -- manual format keymap (NvChad style)
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ async = true })
      end, { desc = "Format file" })
    end,
  },

  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",

    lazy = false,
    config = function()
      require("multiple-cursors").setup()

      -- Alt + Up
      vim.keymap.set("n", "<A-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
        desc = "Add cursor up",
      })

      vim.keymap.set("x", "<A-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
        desc = "Add cursor up",
      })

      -- Alt + Down
      vim.keymap.set("n", "<A-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
        desc = "Add cursor down",
      })

      vim.keymap.set("x", "<A-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
        desc = "Add cursor down",
      })

      -- Mouse support
      vim.keymap.set({ "n", "x" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {
        desc = "Toggle cursor with mouse",
      })

      -- Visual block / word selection
      vim.keymap.set("x", "<leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", {
        desc = "Add cursors to visual area",
      })

      vim.keymap.set({ "n", "x" }, "<leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", {
        desc = "Add cursors to word",
      })

      vim.keymap.set({ "n", "x" }, "<leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", {
        desc = "Add cursors in previous area",
      })
    end,
  },


  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
    },
    ft = "python",                                                                                       -- Load when opening Python files
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },                                                                   -- Open picker on keymap
    },
    opts = {                                                                                             -- this can be an empty lua table - just showing below for clarity.
      search = {},                                                                                       -- if you add your own searches, they go here.
      options = {},                                                                                      -- if you add plugin options, they go here.
    },
  },



  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = false,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,

          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true, -- shows a message with information about the refactor on success
        -- i.e. [Refactor] Inlined 3 variable occurrences
      })
    end,
    opts = {},
  },


  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
    },
    ft = "python",                                                                                  -- Load when opening Python files
    keys = { { "lpv", "<cmd>VenvSelect<cr>" } },                                                     -- Open picker on keymap
    opts = {
      options = {},                                                                                 -- plugin-wide options
      search = {}                                                                                   -- custom search definitions
    },
  } }
