local wezterm = require("wezterm")
local c = {}
local act = wezterm.action

if wezterm.config_builder then
	c = wezterm.config_builder()
end
c.color_scheme = "Catppuccin Mocha"
c.window_background_opacity = 0.9

c.font_size = 10.0
c.font = wezterm.font_with_fallback({
	{
		family = "IosevkaTerm Nerd Font",

		--  disable ligatures
		--harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	},
})

c.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
c.warn_about_missing_glyphs = false
c.pane_focus_follows_mouse = true
c.hide_tab_bar_if_only_one_tab = true
c.debug_key_events = false
c.enable_scroll_bar = false
c.adjust_window_size_when_changing_font_size = false
c.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 500 }

c.keys = {
	{
		key = "Space",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SendKey({ key = "Space", mods = "SHIFT" }),
	},
	-- override the default keybindings
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "Enter", mods = "ALT" }),
	},
	{
		key = "Space",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendKey({ key = "Space", mods = "CTRL|SHIFT" }),
	},
	{
		key = "z",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = "z", mods = "CTRL" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Send 'CTRL-A' to the terminal when pressing CTRL-A, CTRL-A

	{
		key = "n",
		mods = "CTRL | SHIFT| ALT",
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

	{ key = "x", mods = "LEADER", action = act.SpawnCommandInNewTab({ args = { "nvim" } }) },

	{ key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },

	{ key = "Tab", mods = "CTRL|SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "Tab", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
	{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}

wezterm.plugin.require(wezterm.config_dir .. "/wezterm-bar").apply_to_config(c, {
	position = "bottom",
	max_width = 24,
	dividers = "slant_right", -- or 'slant_left', 'arrows', 'rounded', false
	indicator = {
		leader = {
			enabled = true,
		},
	},
	tabs = {
		brackets = {
			active = { "", "" },
			inactive = { "", "" },
		},
	},
})

return c
