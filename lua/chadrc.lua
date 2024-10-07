-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_dark",
  theme_toggle = { "ayu_dark", "one_light" },

  hl_override = {
    Comment = {
      italic = true,
    },
    ["@comment"] = {
      italic = true,
    },
    ["@string"] = {
      italic = true,
    },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
  statusline = {
    theme = "default",
  },
  mason = {
    pkgs = {
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
}

return M
