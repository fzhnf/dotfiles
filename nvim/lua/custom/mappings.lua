---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>h"] = { "<cmd> sp <CR>", "split horizontal" },
    ["<leader>v"] = { "<cmd> vsp <CR>", "split vertical" },
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
