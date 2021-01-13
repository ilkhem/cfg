-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- {{{ Error handling -- }}}
require("main.error-handling")


 -- Themes
require("main.theme")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")


-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}

-- Layouts
RC.layouts = main.layouts()
awful.layout.layouts = RC.layouts

-- Tags
RC.tags = main.tags()

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal


-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Statusbar: Wibar

-- awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
require("deco.statusbar")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}


-- Autostart
-- local function run_once(cmd_arr)
--     for _, cmd in ipairs(cmd_arr) do
--         awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
--     end
-- end

-- run_once({ "nitrogen --restore", "picom", "nm-applet", "libinput-gestures-setup start", "xmodmap /home/ilyes/.Xmodmap", "powerkit" })  -- entries must be comma-separated

-- -- awful.spawn.with_shell("picom --config  $HOME/.config/picom/picom.conf")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("xmodmap /home/ilyes/.Xmodmap")
awful.spawn.with_shell("xcape -e 'Control_L=Escape'")
awful.spawn.with_shell("powerkit")
awful.spawn.with_shell("libinput-gestures-setup start")
