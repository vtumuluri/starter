local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "deno_fmt" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
    -- yaml = { "prettier" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    python = { "autopep8" },
    c = { "clang_fmt" },
    cxx = { "clang_fmt" },
    cpp = { "clang_fmt" },
    cs = { "clang_fmt" },
    h = { "clang_fmt" },
    proto = { "clang_fmt" },
    nix = { "nixpkgs_fmt" },
  },

  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
