-- Standard awesome library
local gears     = require("gears")
local awful     = require("awful")
local lain = require("lain")

-- Beautiful theme library
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}


local markup = lain.util.markup
local theme = beautiful.get()
local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}


-- -- -- -- -- -- -- -- -- -- --- -- -- -- --
-- Widgets

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#7788af", "%a %d %b ") .. markup("#535f7a", ">") .. markup("#de5e1e", " %H:%M "))
mytextclock.font = theme.font



-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Noto Sans Mono Medium 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743,
    notification_preset = { font = "Noto Sans Mono Medium 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    notify = "off",
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
    end
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end

        widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
    end
})


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  -- set_wallpaper(s)

  -- a separator
  s.mysep = wibox.widget{
    markup = markup.fontfg(theme.font, '#434758', '|'),
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }


  -- prints spotify status
  -- TODO: update to use playerctl
  s.myspotifystatus = awful.widget.watch("spotify-status", 1, function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font, '#e1acff', stdout))
  end)


  -- prints battery status
  s.mybatterystatus = awful.widget.watch("bat-status", 15, function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, stdout))
  end)


  -- print number of pcaman updates
  s.mypacupdates = awful.widget.watch("pacupdate", 360, function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font, '#24beae', " " .. stdout))
  end)


  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.focused,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 20, bg = theme.bg_normal, fg = theme.fg_normal })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          s.mylayoutbox,
          s.mytaglist,
          s.mypromptbox,
          -- s.mytasklist,
          s.mysep,
      },
      s.mytasklist, -- Middle widget
      -- nil,
      { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          -- awful.widget.watch("spotify-status", 1),
          s.myspotifystatus,
          s.mysep,
          -- netdownicon,
          -- netdowninfo,
          -- netupicon,
          -- netupinfo.widget,
          cpuicon,
          cpu.widget,
          s.mysep,
          memicon,
          memory.widget,
          s.mysep,
          weathericon,
          theme.weather.widget,
          -- tempicon,
          -- temp.widget,
          s.mysep,
          baticon,
          -- bat.widget,
          s.mybatterystatus,
          -- s.mysep,
          -- volicon,
          -- theme.volume.widget,
          s.mysep,
          s.mypacupdates,
          s.mysep,
          clockicon,
          mytextclock,
          theme.cal.widget,
          s.mysep,
          awful.widget.keyboardlayout(),
          -- s.mylayoutbox,
          wibox.widget.systray(),
      },
  }




--   -- Create the wibox
--   s.mywibox = awful.wibar({ position = "top", screen = s, height=20 })

--   -- Add widgets to the wibox
--   s.mywibox:setup {
--     layout = wibox.layout.align.horizontal,
--     { -- Left widgets
--       layout = wibox.layout.fixed.horizontal,
--       RC.launcher,
--       s.mytaglist,
--       s.mypromptbox,
--     },
--     s.mytasklist, -- Middle widget
--     { -- Right widgets
--       layout = wibox.layout.fixed.horizontal,
--       mykeyboardlayout,
--       wibox.widget.systray(),
--       mytextclock,
--       s.mylayoutbox,
--     },
--   }

end)
-- }}}

