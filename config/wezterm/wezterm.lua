local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.log_info("reloading")

require("tabs").setup(config)
require("mouse").setup(config)
require("links").setup(config)
require("keys").setup(config)

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
-- config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.color_scheme_dirs = { wezterm.home_dir .. ".local/share/nvim/lazy/tokyonight.nvim/extras/wezterm" }
config.color_scheme = "tokyonight_night"
wezterm.add_to_config_reload_watch_list(config.color_scheme_dirs[1] .. config.color_scheme .. ".toml")

config.underline_thickness = 3
config.cursor_thickness = 2
config.underline_position = -6

config.term = "wezterm"
config.window_decorations = "RESIZE"

--config.color_scheme = "OneDark (base16)"

--[[config.colors = {
	background = "#21252B",

	cursor_bg = "#FF5F1F",
	cursor_fg = "#000000",
	cursor_border = "#000000",

	ansi = {
		"#21252B",
		"#E06C75",
		"#98C379",
		"#FF8C04",
		"#B6B6B6",
		"#C678DD",
		"#56B6C2",
		"#FFFFFF",
	},
	brights = {
		"#B6B6B6",
		"#E06C75",
		"#98C379",
		"#FF5F1F",
		"#B6B6B6",
		"#C678DD",
		"#56B6C2",
		"#FFFFFF",
	},
}]]

config.font_size = 11
config.font = wezterm.font({ family = "Fira Code", weight = "Bold" })
config.bold_brightens_ansi_colors = true
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Maple Mono", weight = "Bold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({ family = "Maple Mono", weight = "DemiBold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({ family = "Maple Mono", style = "Italic" }),
	},
}

-- Cursour
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- config.window_background_opacity = 0.9
-- cell_width = 0.9,
config.scrollback_lines = 10000

return config
