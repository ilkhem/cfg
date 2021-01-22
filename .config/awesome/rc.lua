-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

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
local function run_once(cmd)
        -- strips any arguments from the command
        local args_start = string.find(cmd, " ")
        local pgrep_name = args_start and cmd:sub(0, args_start - 1) or cmd
        -- run the pgrep statement against just the command name without args
        local command = "pgrep -u $USER -x " .. pgrep_name .. " > /dev/null || " .. cmd
        -- run the command in async fashion
        awful.spawn.easy_async_with_shell(
            command,
            function( stdout, stderr, exitreason, exitcode )
                if exitcode ~= 0 then
                    naughty.notify({
                        preset  = naughty.config.presets.critical           ,
                        text    = string.format(    "%s\n\n%s\n%s\n%s\n%s",
                                                    command,
                                                    stdout,
                                                    stderr,
                                                    exitreason,
                                                    exitcode )              })
                end
            end )
        -- awful.spawn.with_shell(command)
end

-- awful.spawn.with_shell("picom")
-- awful.spawn.with_shell("nm-applet")
-- awful.spawn.with_shell("volumeicon")
-- awful.spawn.with_shell("xcape -e 'Control_L=Escape'")
-- awful.spawn.with_shell("nitrogen --restore")
-- awful.spawn.with_shell("picom")
-- awful.spawn.with_shell("nm-applet")
-- awful.spawn.with_shell("volumeicon")
-- awful.spawn.with_shell("xmodmap /home/ilyes/.Xmodmap")


run_once("picom")
run_once("lxsession")
-- run_once("nitrogen --restore")
run_once("nm-applet")
run_once("volumeicon")
run_once("xcape -e 'Control_L=Escape'")
run_once("powerkit")
-- run_once("libinput-gestures-setup start")
-- run_once("udiskie")
