-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon

local M = {}  -- menu
local _M = {} -- module

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- This is used later as the default terminal and editor to run.
local terminal = RC.vars.terminal

-- Variable definitions
-- This is used later as the default terminal and editor to run.
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

M.awesome = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  -- { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "Terminal", terminal },
  -- { "Shutdown/Logout", "oblogout" },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end }
}

M.favorite = {
  { "thunar", "thunar" },
  { "geany", "geany" },
  { "spotify", "spotify" },
  -- { "firefox", "firefox", awful.util.getdir("config") .. "/firefox.png" },
  { "chromium", "chromium" },
  { "firefox", "firefox" },
  { "thunderbird", "thunderbird" },
  { "libreoffice", "libreoffice" },
  -- { "transmission", "transmission-gtk" },
  -- { "gimp", "gimp" },
  -- { "inkscape", "inkscape" },
  -- { "screenshooter", "xfce4-screenshooter" }
}

-- M.network_main = {
--   { "wicd-curses", "wicd-curses" },
--   { "wicd-gtk", "wicd-gtk" }
-- }

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()

  -- Main Menu
  local menu_items = {
    { "awesome", M.awesome, beautiful.awesome_subicon },
    { "open terminal", terminal },
    -- { "network", M.network_main },
    { "Faves", M.favorite },
    { "Log out", function() awesome.quit() end },
    { "Sleep", "systemctl suspend" },
    { "Restart", "systemctl reboot" },
    { "Shutdown", "systemctl poweroff" },
  }

  return menu_items
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })

