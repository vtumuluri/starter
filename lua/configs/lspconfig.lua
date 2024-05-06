-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "terraformls", "tailwindcss" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  local attach = on_attach
  if lsp == "tailwindcss" then
    attach = function (client, bufnr)
      require("tailwindcss-colors").buf_attach(bufnr)
      on_attach(client, bufnr)
    end
  end
  lspconfig[lsp].setup {
    on_attach    = attach,
    on_init      = on_init,
    capabilities = capabilities,
  }
end


lspconfig.omnisharp.setup {
  cmd                                     = { "omnisharp" },
  enable_editorconfig_support             = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers                 = true,
  organize_imports_on_format              = true,
  enable_import_completion                = true,
  sdk_include_prereleases                 = true,
  analyze_open_documents_only             = false,
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
    excludeLanguages            = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences                 = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation    = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets   = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles              = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables                   = {},
  },
}

--
-- lspconfig.pyright.setup { blabla}
lspconfig.helm_ls.setup {
  settings      = {
    ['helm-ls'] = {
      yamlls    = {
        path    = "yaml-language-server",
      }
    }
  }
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    yaml = {
      format = { enable = true },
      validate = true,
      completion = true,
      schemastore = { enable = true },
      schemas = {
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.0-standalone/all.json"] = "*.yaml",
        -- kubernetes = "*.yaml",
        -- kubernetes = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.0-standalone/all.json",
      },
    },
  },
}
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt-lldb",
    },
  },
})
