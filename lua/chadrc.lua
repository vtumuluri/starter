-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "dark_horizon",
  theme_toggle = { "dark_horizon", "one_light" },
  hl_override = {
    Comment = {
      italic = true,
      fg = "teal",
    },
    ["@comment"] = {
      italic = true,
      fg = "teal",
    },
    ["@string"] = {
      italic = true,
      fg = "orange",
    },
  },
  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },
  statusline = {
    theme = "default",
  },
}

return M
