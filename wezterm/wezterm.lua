local wezterm = require("wezterm")
local act = wezterm.action
local c = wezterm.config_builder()
c.color_scheme = "Catppuccin Mocha"
c.font_size = 9.0
c.window_background_opacity = 0.9
c.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Medium",
	},
	"Symbols Nerd Font",
	"Noto Sans Symbols 2",
	"Noto Color Emoji",
})
c.enable_scroll_bar = false
c.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
c.use_fancy_tab_bar = false
c.tab_bar_at_bottom = true
c.hide_tab_bar_if_only_one_tab = true
c.adjust_window_size_when_changing_font_size = false
c.keys = {
	{ key = "x", mods = "ALT", action = act.SpawnCommandInNewTab({ args = { "nvim" } }) },
	{ key = "<", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = ">", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
}

wezterm.plugin.require("/home/fzhnf/.config/wezterm/wezterm-bar").apply_to_config(c, {
	position = "bottom",
	max_width = 32,
	dividers = "slant_right", -- or "slant_left", "arrows", "rounded", false
	indicator = {
		leader = {
			enabled = true,
			off = " ",
			on = " ",
		},
		mode = {
			enabled = true,
			names = {
				resize_mode = "RESIZE",
				copy_mode = "VISUAL",
				search_mode = "SEARCH",
			},
		},
	},
	tabs = {
		numerals = "arabic", -- or "roman"
		pane_count = false, -- or "subscript", false
		brackets = {
			active = { "", ":" },
			inactive = { "", ":" },
		},
	},
	clock = { -- note that this overrides the whole set_right_status
		enabled = false,
		format = "%H:%M", -- use https://wezfurlong.org/wezterm/config/lua/wezterm.time/Time/format.html
	},
})

return c
