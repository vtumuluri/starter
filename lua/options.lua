require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rx", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})
local augroup = vim.api.nvim_create_augroup("jdtls", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  group = augroup,
  callback = require("configs.jdtls").setup,
})

-- vim.opt.list = true
-- vim.opt.listchars = {
--   tab = '≫',
--   trail = '.',
--   nbsp = '⎵'
-- }

-- vim.g.clipboard = {
--   name = "WslClipboard",
--   copy = {
--     ["+"] = { "clip.exe" },
--     ["*"] = { "clip.exe" },
--   },
--   paste = {
--     ["+"] = {
--       "/mnt/c/Windows/System32/WindowsPowerShell/v1.0///powershell.exe",
--       "-c",
--       '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     ["*"] = {
--       "/mnt/c/Windows/System32/WindowsPowerShell/v1.0///powershell.exe",
--       "-c",
--       '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--   },
--   cache_enabled = false,
-- }

-- DAP configurations
local dap = require("dap");
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
};
dap.adapters.cppdbg = {
  type = "executable",
  command = os.getenv("VSCODECPPTOOLS_HOME") .. "/bin/OpenDebugAD7",
  id = "cppdbg",
};

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
};
dap.configurations.c = dap.configurations.cpp;
dap.configurations.rust = dap.configurations.cpp;

dap.configurations.java = {
  {
    type = "java",
    name = "Debug (Launch) - Current File",
    request = "launch",
    stopOnEntry = true,
    console = "internalConsole",
    workspace = "${workspaceFolder}",
    classPath = "${workspaceFolder}/bin",
    mainClass = "${fileBasenameNoExtension}",
    vmArgs = "-Djava.library.path=${workspaceFolder}/lib",
  },
  {
    type = "java",
    name = "Debug (Launch) - Custom",
    request = "launch",
    stopOnEntry = true,
    console = "internalConsole",
    workspace = "${workspaceFolder}",
    classPath = "${workspaceFolder}/bin",
    mainClass = function()
      return vim.fn.input('Main class: ')
    end,
    vmArgs = "-Djava.library.path=${workspaceFolder}/lib",
  },
  {
    type = "java",
    name = "Debug (Attach) - Remote",
    request = "attach",
    hostName = "localhost",
    port = function()
      return vim.fn.input('Port: ')
    end,
  },
};

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = 0, bg = 'red' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = 0, bg = 'orange' })

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'});
vim.fn.sign_define('DapStopped', {text='|>', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'});


local dapui = require("dapui");
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
