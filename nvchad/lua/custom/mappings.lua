---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>h"] = { "<cmd> sp <CR>", "split horizontal" },
    ["<leader>v"] = { "<cmd> vsp <CR>", "split vertical" },
    ["<C-M-S-Tab>"] = { "<cmd> lua require('base46').toggle_theme() <CR>", "toggle theme" },
  },
}

M.telescope = {
  n = {
    ["<leader>fd"] = { "<cmd> Telescope zoxide list <CR>", "change directory" },
    ["<leader>lg"] = { "<cmd> LazyGit <CR>", "lazygit" },
  },
}

-- more keybinds!

return M
