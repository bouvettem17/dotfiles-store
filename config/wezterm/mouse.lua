local wezterm = require("wezterm")

local M = {}

---@param config Config
function M.setup(config)
	config.alternate_buffer_wheel_scroll_speed = 1
	config.bypass_mouse_reporting_modifiers = require("keys").mod
	config.mouse_bindings = {}
end

return M
