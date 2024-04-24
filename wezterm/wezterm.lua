local wezterm = require("wezterm")
local c = {}
local k = require("keymap")

if wezterm.config_builder then
	c = wezterm.config_builder()
end

c.leader = k.leader
c.keys = k.keys
c.key_tables = k.key_tables

c.color_scheme = "Catppuccin Mocha"

c.font_size = 10.0
c.font = wezterm.font_with_fallback({
	{
		family = "Iosevka Nerd Font",

		--  disable ligatures
		--harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
		weight = "Medium",
		scale = 1.0,
	},
	"Symbols Nerd Font Mono",
	"Noto Color Emoji",
})

c.window_background_opacity = 0.9
c.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

c.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.8,
}
c.adjust_window_size_when_changing_font_size = false

c.warn_about_missing_glyphs = false
c.hide_tab_bar_if_only_one_tab = true
c.debug_key_events = false
c.enable_scroll_bar = false
c.disable_default_key_bindings = true
c.use_fancy_tab_bar = false
c.tab_bar_at_bottom = true
c.window_close_confirmation = "AlwaysPrompt"
c.default_workspace = "main"

wezterm.plugin.require(wezterm.config_dir .. "/wezterm-bar").apply_to_config(c, {
	-- position = "bottom",
	max_width = 24,
	dividers = "slant_right", -- or 'slant_left', 'arrows', 'rounded', false
	indicator = {
		leader = {
			enabled = true,
		},
	},
	tabs = {
		brackets = {
			active = { "", "." },
			inactive = { "", "." },
		},
	},
	clock = { enabled = false },
})

return c
