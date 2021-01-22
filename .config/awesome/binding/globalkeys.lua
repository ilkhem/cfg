-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

local lain = require("lain")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal
local altkey = "Mod1"
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()


local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local globalkeys = gears.table.join(
    -- awesome
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "Delete", function() awesome.spawn.with_shell("xscreensaver-command -lock") end,
              {description = "lock screen", group = "awesome"}),
    awful.key({ modkey, "Shift", "Control"   }, "Delete", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "x", function () RC.mainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),
    -- awful.key({ modkey, "Shift" }, "b", function ()
    --         for s in screen do
    --                 for _, c in pairs(s.all_clients) do
    --                     if c == nil then return end
    --                     awful.titlebar:toggle(c)
    --                 end
    --         end
    --     end,
    --     {description = "toggle titlebar", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey, "Shift" }, "l",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "a", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ altkey, "Control" }, "j", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "k", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),


    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- client globals
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey }, "Tab", function() awful.client.focus.byidx(1) end,
              {description = "cycle clients", group = "client"}),
    -- awful.key({ modkey,           }, "Tab",
    --           function ()
    --               awful.client.focus.history.previous()
    --               if client.focus then
    --                   client.focus:raise()
    --               end
    --           end,
    --           {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey, "Control" }, "n",
          function ()
              local c = awful.client.restore()
              -- Focus restored client
              if c then c:emit_signal("request::activate", "key.unminimize", {raise = true}) end
          end,
          {description = "restore minimized", group = "client"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Standard programs
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "applications"}),
    awful.key({ modkey }, "w", function() awful.spawn("firefox") end,
        {description = "launch firefox", group = "applications"}),
    awful.key({ modkey }, "b", function() awful.spawn("thunderbird") end,
        {description = "launch thunderbird", group = "applications"}),
    awful.key({ modkey }, "e", function() awful.spawn("thunar") end,
        {description = "launch thunar", group = "applications"}),
    awful.key({ modkey }, "v", function() awful.spawn(terminal .. " -e nvim") end,
        {description = "launch nvim", group = "applications"}),


    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Custom scripts
    awful.key({ modkey, "Control" }, "p", function() awful.spawn.with_shell("/home/ilyes/.local/bin/change-screen-config") end,
        {description = "toggle monitor profile", group = "custom scripts"}),
    -- awful.key({ modkey, "Shift" }, "p", function() awful.spawn.with_shell("/home/ilyes/.config/spectrwm/init2scr.sh") end,
    --     {description = "swap to 2 screens", group = "custom scripts"}),
    -- awful.key({ modkey, "Control" }, "k", function() awful.spawn.with_shell("/home/ilyes/.local/bin/nextkbd") end,
    awful.key({ modkey, "Control" }, "k", function() mykeyboardlayout.next_layout() end,
        {description = "toggle keyboard layout", group = "custom scripts"}),



    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, ".",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, ",",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, ".",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, ",",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "Tab",   function () awful.layout.inc( 1)                end,
              {description = "cycle layout", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),

    -- screen manip
    awful.key({ modkey,           }, ".", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, ",", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),


    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Resize
    --awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    --awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey, "Control" }, "Down",
              function () awful.client.moveresize( 0, 0, 0, -20) end),
    awful.key({ modkey, "Control" }, "Up",
              function () awful.client.moveresize( 0, 0, 0,  20) end),
    awful.key({ modkey, "Control" }, "Left",
              function () awful.client.moveresize( 0, 0, -20, 0) end),
    awful.key({ modkey, "Control" }, "Right",
              function () awful.client.moveresize( 0, 0,  20, 0) end),

    -- Move
    awful.key({ modkey, "Shift"   }, "Down",
              function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Up",
              function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Left",
              function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey, "Shift"   }, "Right",
              function () awful.client.moveresize( 20,   0,   0,   0) end),

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Rofi
    awful.key({ modkey, "Shift" }, "Return",
        function() awful.spawn.with_shell("rofi -show run -show-icons -config ~/.config/rofi/themes/dmenu.rasi") end,
              {description = "rofi launcher", group = "launcher"}),
    awful.key({ modkey }, "space",
        function() awful.spawn.with_shell("rofi -show drun -show-icons -config ~/.config/rofi/themes/center.rasi") end,
              {description = "rofi drun launcher", group = "launcher"}),
    -- awful.key({ modkey }, "f",
    --     function() awful.spawn('rofi -show find -modi find:~/.local/share/rofi/finder.sh -config ~/.config/rofi/themes/center.rasi -display-drun "Find: " -drun-display-format "{name}"') end,
    --           {description = "rofi file finder", group = "launcher"}),
    awful.key({ modkey, "Mod1" }, "space",
        -- function() awful.spawn.with_shell('rofi -show find -modi find:~/.local/share/rofi/finder.sh -config ~/.config/rofi/themes/center.rasi -display-drun "Find: " -drun-display-format "{name}"') end,
        -- In the following, `find $HOME /media` could be replaced by
        -- `locate $HOME media` if one wishes to use locate instead of find
        function() awful.spawn.with_shell('dmenu-find') end,
              {description = "rofi file finder", group = "launcher"}),
    awful.key({ "Mod1" }, "Tab",
        function() awful.spawn.with_shell("rofi -show window -show-icons -config ~/.config/rofi/themes/center.rasi") end,
              {description = "rofi window switcher", group = "launcher"}),




    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- custom rofi (dmenu) scripts
    awful.key({ "Mod1", "Control" }, "space",
        function() awful.spawn.with_shell("dmenu-emoji") end,
              {description = "a dmenu for emojis", group = "custom scripts"}),
    awful.key({ "Mod1", "Control" }, "e",
        function() awful.spawn.with_shell("dmenu-edit-config") end,
              {description = "a dmenu for editing configs", group = "custom scripts"}),
    awful.key({ "Mod1", "Control" }, "s",
        function() awful.spawn.with_shell("dmenu-scrot") end,
              {description = "a dmenu for editing configs", group = "custom scripts"}),



    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- fn keys

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.with_shell("xbacklight -inc 10") end,
              {description = "Brightness up", group = "fn keys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.with_shell("xbacklight -dec 10") end,
              {description = "Brightness down", group = "fn keys"}),
    -- Volume
    awful.key({ }, "XF86AudioRaiseVolume",
            function () awful.spawn.with_shell("amixer -c 0 sset Master 5%+ unmute") end,
            {description = "volume up", group = "fn keys"}),
    awful.key({ }, "XF86AudioLowerVolume",
            function () awful.spawn.with_shell("amixer -c 0 sset Master 5%- unmute ") end,
            {description = "volume down", group = "fn keys"}),
    awful.key({ }, "XF86AudioMute",
            function () awful.spawn.with_shell("amixer -q -D pulse sset Master toggle") end,
            {description = "mute/unmute", group = "fn keys"}),
    -- Media
    awful.key({ }, "XF86AudioNext",
    -- function() awful.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next ") end,
            function() awful.spawn.with_shell("playerctl next") end,
            {description = "Next song", group = "fn keys"}),
    awful.key({ }, "XF86AudioPrev",
            -- function() awful.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end,
            function() awful.spawn.with_shell("playerctl previous") end,
            {description = "Previous song", group = "fn keys"}),
    awful.key({ }, "XF86AudioPlay",
            -- function() awful.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end,
            function() awful.spawn.with_shell("playerctl play-pause") end,
            {description = "Play/pause", group = "fn keys"})
  )

  return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
