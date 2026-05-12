local wezterm = require("wezterm")
local config = {
	keys = {
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		-- Map Cmd+Opt+number to send Alt+number for tmux window selection
		{ key = "1", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "1", mods = "ALT" }) },
		{ key = "2", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "2", mods = "ALT" }) },
		{ key = "3", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "3", mods = "ALT" }) },
		{ key = "4", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "4", mods = "ALT" }) },
		{ key = "5", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "5", mods = "ALT" }) },
		{ key = "6", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "6", mods = "ALT" }) },
		{ key = "7", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "7", mods = "ALT" }) },
		{ key = "8", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "8", mods = "ALT" }) },
		{ key = "9", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "9", mods = "ALT" }) },
		{ key = "0", mods = "CMD|OPT", action = wezterm.action.SendKey({ key = "0", mods = "ALT" }) },
	},
}
config.color_scheme = "Dracula"
config.color_scheme = "Dark Pastel (Gogh)"
config.font_size = 18.0
return config
