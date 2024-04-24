local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

local default_keybinding = {
	{
		key = "C",
		mods = "CTRL",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	-- paste from the clipboard
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "D", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },

	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
}

M.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 500 }

M.keys = {
	{
		key = "Space",
		mods = "LEADER",
		action = wezterm.action.SendKey({ key = "Space", mods = "SHIFT" }),
	},
	{ key = "C", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "Space", mods = "LEADER", action = act.ActivateCommandPalette },
	{
		key = "R",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_mode",
			one_shot = false,
		}),
	},
	{ key = "W", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	{ key = "X", mods = "LEADER", action = act.SpawnCommandInNewTab({ args = { "nvim" } }) },

	{
		key = "F",
		mods = "SHIFT|CTRL",
		action = act.Search({ CaseSensitiveString = "" }),
	},
	{
		key = "S",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "V",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "n",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action_callback(function(_, pane)
			local _, _ = pane:move_to_new_window()
		end),
	},
	{
		key = "t",
		mods = "CTRL | SHIFT| ALT",
		action = wezterm.action_callback(function(_, pane)
			local _, _ = pane:move_to_new_tab()
		end),
	},

	{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },

	{ key = "Tab", mods = "CTRL|SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "Tab", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
	{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
	{
		key = "H",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "K",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "J",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	table.unpack(default_keybinding),
}

for i = 1, 9 do
	table.insert(M.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

M.key_tables = {
	resize_mode = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return M
