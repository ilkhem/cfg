-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Custom Local Library: Common Functional Decoration
require("deco.titlebar")

-- reading
-- https://awesomewm.org/apidoc/classes/signals.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)

  -- Set the new clients at the slave instead of setting it master
  if not awesome.startup then awful.client.setslave(c) end

  -- Prevent clients from being unreachable after screen count changes.
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)
  end
end)



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Warp mouse to the center of focused client on focus change and swap

-- function move_mouse_onto_focused_client()
--     local c = client.focus
--     gears.timer( {  timeout = 0.1,
--                 autostart = true,
--                 single_shot = true,
--                 callback =  function()
--                     if mouse.object_under_pointer() ~= c then
--                         local geometry = c:geometry()
--                         local x = geometry.x + geometry.width/2
--                         local y = geometry.y + geometry.height/2
--                         mouse.coords({x = x, y = y}, true)
--                     end
--                 end } )
-- end

-- client.connect_signal("focus", move_mouse_onto_focused_client)
-- client.connect_signal("swapped", move_mouse_onto_focused_client)


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- move focus to last focused client on client close
client.connect_signal("unmanage", function()
        local s = awful.screen.focused()
        local c = awful.client.focus.history.get(s, 0)
        if c == nil then return end
        awful.client.focus.byidx(0, c)
        -- move_mouse_onto_focused_client()
        -- awful.client.focus.history.previous()
        -- -- local c = awful.client.focus.history.get(awful.screen.focused(), 1)
        -- c:activate{}
        -- awful.client.focus.history.bydirection("up")
end)


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- focus on last focused client in current tag after tag change
screen.connect_signal("tag::history::update", function()
        local s = awful.screen.focused()
        local c = awful.client.focus.history.get(s, 0)
        if c == nil then return end
        awful.client.focus.byidx(0, c)
end)


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)
-- client.connect_signal("mouse::move", function(c)
--     c:emit_signal("request::activate", "mouse_move", {raise = true})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

