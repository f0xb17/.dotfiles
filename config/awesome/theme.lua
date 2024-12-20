local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local naughty = require("naughty")
local gears = require("gears")

local theme = {}
local notify = naughty.config

theme.font          = "sans 8"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#737aa2"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.gap_single_client = true
theme.border_width  = dpi(4)
theme.border_normal = "#1f2335"
theme.border_focus  = "#3b4261"

notify.defaults.timeout = 5
notify.defaults.icon_size = dpi(50)
notify.defaults.margin = dpi(16)
notify.defaults.width = dpi(512)
notify.padding = dpi(8)
notify.spacing = dpi(10)
theme.notification_font = "FiraCode Nerd Font Propo 12"

theme.wallpaper = gears.filesystem.get_configuration_dir() .. "01.jpg"

return theme
