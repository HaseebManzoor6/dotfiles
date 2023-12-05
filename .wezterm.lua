local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end


-- colorschemes --
-- builtin colorschemes: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme_dirs = {'C:/Users/hasee/Documents/Wezterm/colors'}

local nice_colors = {
	'UltraViolent',
	{'Gruvbox dark, soft (base16)', 'Gruvbox light, soft (base16)'},
    {'Heetch Dark (base16)', 'Heetch Light (base16)'},
    {'Unikitty Dark (base16)', 'Unikitty Light (base16)'},
    'SeaShells',
    {'Grayscale Dark (base16)', 'Grayscale Light (base16)'},
	'Calamity',
	'FunForrest',
	{'Rosé Pine Moon (Gogh)','Rosé Pine Dawn (base16)'},
}



-- Launch menu

-- SpawnCommands
local spawn_cmd = {label='CMD', args={'cmd.exe','/k','C:/Users/hasee/cmdrc.cmd','--color'}, cwd='C:/Users/hasee'}
local spawn_pwsh = {label='PWSH', args={'pwsh','-NoLogo'}, cwd='C:/Users/hasee'}

config.default_prog = spawn_pwsh.args



-- Settings

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- keybinds
config.keys = {
	-- paste from the clipboard
	{key="V", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
	-- copy to clipboard
	{key="C", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="ClipboardAndPrimarySelection"}},
    -- launcher menu
    {key='Enter', mods='CTRL', action=wezterm.action.ShowLauncher},
    -- change color scheme
    {key='0', mods='CTRL',       action=act.EmitEvent 'next-color-scheme'},
    {key='0', mods='CTRL|ALT',   action=act.EmitEvent 'prev-color-scheme'},
    -- toggle lightmode
    {key='9', mods='CTRL',       action=act.EmitEvent 'toggle-light-colorscheme'},
    -- Split horizontal/vertical (swapped from defaults)
    {key='%', mods='CTRL|SHIFT|ALT', action=wezterm.action.SplitVertical {domain="CurrentPaneDomain"}},
    {key='"', mods='CTRL|SHIFT|ALT', action=wezterm.action.SplitHorizontal {domain="CurrentPaneDomain"}},
}




local my_color=0
local light_mode=0

-- colorscheme cycler
local apply_color=function(cfg)
    local color=nice_colors[my_color + 1]

    if type(color) == "table" then
        color=color[light_mode + 1]
    end
    cfg.color_scheme=color
end

local update_colors=function(window, pane)
    local overrides = window:get_config_overrides() or {}
    apply_color(overrides)
    window:set_config_overrides(overrides)
end

wezterm.on('toggle-light-colorscheme', function(window, pane)
    light_mode = (light_mode + 1) % 2
    update_colors(window,pane)
end)
wezterm.on('next-color-scheme', function(window, pane)
    my_color = ((my_color+1) % (#nice_colors))
    update_colors(window,pane)
end)
wezterm.on('prev-color-scheme', function(window, pane)
    my_color = ((my_color-1) % (#nice_colors))
    update_colors(window,pane)
end)

apply_color(config)

return config
