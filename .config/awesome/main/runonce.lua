local naughty   = require( "naughty" )
local awful     = { spawn = require( "awful.spawn" ) }
local string    = { sub = string.sub,
                    find = string.find,
                    format = string.format }

-- This function makes sure the application is not restarted when awesome is reloaded
local function run_once( command )
        local args_start = string.find( command, " " )
        local pgrep_name = args_start and command:sub( 0, args_start - 1 ) or command

        local command = "pgrep -u $USER -x " .. pgrep_name .. " > /dev/null || (" .. command .. ")"

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
end

-- Start these if not already running

-- awful.spawn.with_shell("picom --config  $HOME/.config/picom/picom.conf")
run_once("nitrogen --restore")
run_once("picom")
run_once("nm-applet")
run_once("volumeicon")
-- awful.spawn.with_shell("xmodmap /home/ilyes/.Xmodmap")
run_once("xcape -e 'Control_L=Escape'")
run_once("powerkit")
run_once("libinput-gestures-setup start")
run_once("udiskie")
