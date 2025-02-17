local M = {}
function M.setup()
  local home = os.getenv('HOME')
  local jdtls = require('jdtls')
  local root_markers = {'gradlew', 'mvnw', '.git'}
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local workspace_folder = home .. '/.cache/jdtls/workspace' .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  -- Helper function for creating keymaps
  function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
  end

  -- The on_attach function is used to set key maps after the language server
  -- attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Regular Neovim LSP client keymappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- Java extensions provided by jdtls
    nnoremap("<leader>oi", jdtls.organize_imports, bufopts, "Organize imports")
    nnoremap("<leader>ev", jdtls.extract_variable, bufopts, "Extract variable")
    nnoremap("<leader>ec", jdtls.extract_constant, bufopts, "Extract constant")
    vim.keymap.set('v', "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
      { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })

    vim.keymap.set("n", "<leader>tf", "<Cmd>lua require('jdtls').test_class()<CR>", { noremap=true, silent=true, buffer=bufnr, desc = "Run test for class" })
    vim.keymap.set("n", "<leader>tm", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { noremap=true, silent=true, buffer=bufnr, desc = "Run test for method" })
  end

  local bundles = {
    home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar',
  };
  vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), "\n"));
  -- print(vim.inspect(bundles))

  local config = {
    flags = {
      debounce_text_changes = 80,
    },
    on_attach = on_attach,
    root_dir = root_dir,
    init_options = {
      bundles = bundles;
    },
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      java = {
        format = {
          settings = {
            -- Use Google Java style guidelines for formatting
            -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
            -- and place it in the ~/.local/share/eclipse directory
            url = home .. "/foundation_formatter.xml",
            profile = "hsdp-foundation-formatter",
          },
        },
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
        implementationsCodeLens = { enabled = true },
        referenceCodeLens = { enabled = true },

        -- Specify any completion options
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
            "org.mockito.Mockito.*",
            "org.mockito.ArgumentMatchers.*",
            "org.mockito.Answers.*"
          },
          filteredTypes = {
            "jakarta",
            "java",
            "javax",
            "ca",
            "com",
            "net",
            "org",
            "com.philips",
            "com.philips.hsdp.cdr"
          },
          importOrder = {
            "jakarta",
            "java",
            "javax",
            "ca",
            "com",
            "net",
            "org",
            "com.philips",
            "com.philips.hsdp.cdr"
          },
        },
        -- Specify any options for organizing imports
        sources = {
          organizeImports = {
            starThreshold = 9999;
            staticStarThreshold = 9999;
          },
        },
        -- How code generation should act
        codeGeneration = {
          toString = {
            -- template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            codeStyle = "STRING_BUILDER_CHAINED",
          },
          hashCodeEquals = {
            useInstanceof = true,
          },
          useBlocks = true,
          generateComments = true,
        },
        templates = {
          fileHeader = {
            "// Copyright Koninklijke Philips N.V. 2023.\n",
          },
        },
        maven = {
          downloadSources = true,
        },
        eclipse = {
          downloadSources = true,
        },
        -- If you are developing in projects with different Java versions, you need
        -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        configuration = {
          updateBuildConfiguration = "automatic",
          -- runtimes = {
          --   {
          --     name = "JavaSE-17",
          --     path = home .. "/.asdf/installs/java/corretto-17.0.4.9.1",
          --   },
          --   {
          --     name = "JavaSE-11",
          --     path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
          --   },
          --   {
          --     name = "JavaSE-1.8",
          --     path = home .. "/.asdf/installs/java/corretto-8.352.08.1"
          --   },
          -- }
        }
      }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
      'jdtls',
      '-configuration', home .. '/.cache/jdtls/config',
      '-data', workspace_folder
  },
  }

  -- Finally, start jdtls. This will run the language server using the configuration we specified,
  -- setup the keymappings, and attach the LSP client to the current buffer
  jdtls.start_or_attach(config)
end

return M
