return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "clang-format",
        "clangd",
        "codelldb",
        "css-lsp",
        "delve",
        "deno",
        "emmet-language-server",
        "goimports",
        "helm-ls",
        "html-lsp",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "omnisharp",
        "prettier",
        "autopep8",
        "pyright",
        "rust-analyzer",
        "stylua",
        "tailwindcss-language-server",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "hcl",
        "terraform",
        "c",
        "cpp",
        "rust",
        "hcl",
        "go",
        "json",
        "java",
        "markdown",
        "markdown_inline",
      },
      git = {
        timeout = 5000,
      },
      indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        group_empty = true,
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  "mfussenegger/nvim-jdtls",
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "yaml_schema"
    end,
  },

  "simrat39/rust-tools.nvim",

  "themaxmarchuk/tailwindcss-colors.nvim",

  {
    "tigion/nvim-asciidoc-preview",
    ft = { "asciidoc" },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/gitbox/notes/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/gitbox/notes/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/gitbox/notes",
        },
        {
          name = "work",
          path = "~/work",
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    event = "LspAttach",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "ThePrimeagen/vim-be-good",
    keys = "<C-?>",
  },

  {
    "junegunn/vim-easy-align",
    ft = { "markdown", "lua", "go", "c", "java" },
  },
}
