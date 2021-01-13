-- {{{ Global Variable Definitions
-- moved here in module as local variable
-- }}}

local home = os.getenv("HOME")

local _M = {
  -- This is used later as the default terminal and editor to run.
  terminal = "alacritty",

  -- Default modkey.
  -- Usually, Mod4 is the key with a logo between Control and Alt.
  -- If you do not like this or do not have such a key,
  -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
  -- However, you can use another modifier like Mod1, but it may interact with others.
  modkey = "Mod4",

  browser           = "firefox",
  mailclient        = "thunderbird",
  mediaplayer       = "spotify",
  scrlocker         = "i3lock",
  -- init2scr   = "/home/ilyes/.config/spectrwm/init2scr.sh",
  -- init1scr   = "/home/ilyes/.config/spectrwm/init1scr.sh",
  -- rofi       = "rofi -show drun -show-icons -config ~/.config/rofi/themes/center.rasi",
  -- rofi_find  = 'rofi -show find -modi find:~/.local/share/rofi/finder.sh -config ~/.config/rofi/themes/center.rasi -display-drun "Find: " -drun-display-format "{name}"',
  -- rofi_tab   = "rofi -show window -show-icons -config ~/.config/rofi/themes/center.rasi",

  -- user defined wallpaper
  -- wallpaper = nil,
  --wallpaper = home .. "/Pictures/your-wallpaper-here.jpg",
}

return _M


