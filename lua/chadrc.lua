-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_light",
  theme_toggle = { "onedark", "ayu_light" },

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
    theme = "minimal",
  },
}

return M
