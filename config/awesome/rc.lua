pcall(require, "luarocks.loader")

local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                            title = "Oops, an error happened!",
                            text = tostring(err) })
        in_error = false
    end)
end

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

modkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
terminal = "alacritty"
launcher = "rofi -show drun"
window = "rofi -show window"

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle
}

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

awful.screen.connect_for_each_screen(function (s)
    set_wallpaper(s)
    s.padding = {top = 35, left = 0, right = 0, bottom = 35}
    awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
end)

globalkeys = gears.table.join(
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "e", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,  }, "space", function () awful.spawn("rofi -show drun") end,
              {description = "show rofi drun menu", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "w", function () awful.spawn("rofi -show window") end,
              {description = "show rofi window menu", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, }, "x", function (c) c:kill() end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey }, "Left", function()
            awful.client.focus.bydirection("left")
                if client.focus then client.focus:raise() end
            end),
    awful.key({ modkey }, "Down", function()
            awful.client.focus.bydirection("down")
                if client.focus then client.focus:raise() end
            end),
    awful.key({ modkey }, "Up", function()
            awful.client.focus.bydirection("up")
                if client.focus then client.focus:raise() end
            end),
    awful.key({ modkey }, "Right", function()
            awful.client.focus.bydirection("right")
                if client.focus then client.focus:raise() end
            end)
)

for i = 1, 6 do
    globalkeys = gears.table.join(globalkeys,
         awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

awful.rules.rules = {
    { rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }
}

client.connect_signal("manage", function (c) 
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("~/.config/awesome/scripts/autorun.sh")
