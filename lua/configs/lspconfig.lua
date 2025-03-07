-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ts_ls", "clangd", "pyright", "terraformls", "tailwindcss", "gopls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  local attach = on_attach
  if lsp == "tailwindcss" then
    attach = function(client, bufnr)
      require("tailwindcss-colors").buf_attach(bufnr)
      on_attach(client, bufnr)
    end
  end
  local attach_hint = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      -- vim.lsp.buf.inlay_hint(bufnr, true)
    end
    attach(client, bufnr)
  end
  lspconfig[lsp].setup {
    on_attach = attach_hint,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.nil_ls.setup {}

lspconfig.omnisharp.setup {
  cmd = { "omnisharp" },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
}
lspconfig.emmet_language_server.setup {
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    --- @type string[]
    excludeLanguages = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
}

--
-- lspconfig.pyright.setup { blabla}
lspconfig.helm_ls.setup {
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
}
local cfg = require("yaml-companion").setup {
  schemas = {
    {
      name = "Kubernetes",
      uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone/all.json",
    },
    {
      name = "OpenAPI",
      uri = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json",
    },
    {
      name = "Docker-Compose",
      uri = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
    },
    {
      name = "ArgoWorkflow",
      uri = "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json",
    },
    {
      name = "Argo CD Application",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
    },
  },
}
lspconfig.yamlls.setup(cfg)
