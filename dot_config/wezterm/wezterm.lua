local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local theme = require('lua/rose-pine').main
local act = wezterm.action

config.default_prog = { '/opt/homebrew/bin/fish' }

config.colors = theme.colors()
config.window_decorations = 'NONE'

config.font = wezterm.font('Noto Sans Mono', { stretch = 'SemiCondensed' })
config.font_size = 16.0

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 64

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	{ key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
	{ key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
	{ key = 'o', mods = 'LEADER', action = act { ActivatePaneDirection = 'Next' } },
	{ key = 'c', mods = 'LEADER', action = act { SpawnTab = 'CurrentPaneDomain' } },
	{ key = '"', mods = 'LEADER', action = act { SplitVertical = { domain = 'CurrentPaneDomain' } } },
	{ key = '%', mods = 'LEADER', action = act { SplitHorizontal = { domain = 'CurrentPaneDomain' } } },
	{ key = 'x', mods = 'LEADER', action = act { CloseCurrentPane = { confirm = true } } },
	{ key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
}

wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

wezterm.on('update-right-status', function(window, _)
	local date = wezterm.strftime '%m-%d %H:%M:%S'

	window:set_right_status(wezterm.format {
		{ Text = date },
	})
end)

return config
