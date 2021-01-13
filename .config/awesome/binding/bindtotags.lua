-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Key bindings

function _M.get(globalkeys)
  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = gears.table.join(globalkeys,

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            tag:view_only()
          end
        end,
        -- {description = "view tag #"..i, group = "tag"}),
        descr_view),

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Toggle tag display.
      awful.key({ modkey, "Control" }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
        -- {description = "toggle tag #" .. i, group = "tag"}),
        descr_toggle),

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        -- {description = "move focused client to tag #"..i, group = "tag"}),
        descr_move),

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:toggle_tag(tag)
            end
          end
        end,
        -- {description = "toggle focused client on tag #" .. i, group = "tag"})
        descr_toggle_focus)

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    )
  end

  return globalkeys
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })

