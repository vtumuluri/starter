require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "v" }, "<leader>ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
map("n", "<leader>tk", "<cmd> Telescope keymaps <CR>", { desc = "Keymaps" })
map("n", "<leader>td", "<cmd> Telescope diagnostics <CR>", { desc = "Diagnostics" })
map("n", "<leader>cd", function()
  local function change_dir(prompt_bufnr, _)
    local actions = require "telescope.actions"
    local actions_state = require "telescope.actions.state"
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = actions_state.get_selected_entry()
      local dir = vim.fn.fnamemodify(selection.path, ":p:h")
      vim.cmd(string.format("cd %s", dir))
    end)
    return true
  end
  require("telescope.builtin").find_files {
    cwd = vim.fn.expand "~" .. "/gitbox",
    find_command = { "fd", "--type", "d" },
    attach_mappings = change_dir,
  }
end, { desc = "Change Directory" })
map("n", "<leader>tt", "<ESC><cmd>lua require('base46').toggle_theme()<CR>", { desc = "Toggle Theme" })
map("n", "<leader>to", "<ESC><cmd>lua require('base46').toggle_transparency()<CR>", { desc = "Toggle Opacity" })
-- map("n", ";", ":", {desc = "enter command mode", nowait = true })
-- map("n", "<leader>yx", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Trouble Symbols" })
-- map("n", "<leader>yw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble Diagnostics" })
-- map("n", "<leader>yd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble Buffer Diagnostics" })
-- map("n", "<leader>yq", "<cmd>Trouble qflist toggle<CR>", { desc = "Trouble QuickFix List" })
-- map("n", "<leader>yl", "<cmd>Trouble loclist toggle<CR>", { desc = "Trouble Location List" })
-- map("n", "gR", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "Trouble LSP References" })

-- DAP Key mappings
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Launch Debug" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<F9>", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end, { desc = "Set Breakpoint" })
map("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end, { desc = "Set Conditional Breakpoint" })
map("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })
map("n", "<Leader>dl", function()
  require("dap").run_last()
end, { desc = "Run last" })
map("n", "<Leader>df", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.frames)
end, { desc = "Debug Frames" })
map("n", "<Leader>ds", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.scopes)
end, { desc = "Debug Scopes" })
map("n", "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Hover debug widgets" })
map("n", "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end, { desc = "Preview debug widgets" })

-- VISUAL MODE

map("v", "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Hover debug widgets" })
map("v", "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end, { desc = "Preview debug widgets" })
