--[[

     Awesome WM configuration template
     github.com/lcpz

--]]
-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- load awful remote for awesome-client
require("awful.remote")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
--local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)

local function notify_error(text, title)
    if not title then
        title = "Oops, an error occurred!"
    end
    naughty.notify({ preset = naughty.config.presets.critical, title = title, text = text })
end

if awesome.startup_errors then
    notify_error({ title = "Oops, there were errors during startup!", text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then
            return
        end
        in_error = true
        notify_error(tostring(err))
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

--run_once({ "picom -f -c", "unclutter -root" }) -- entries must be separated by commas
awful.spawn.easy_async(os.getenv("HOME") .. "/.fehbg")

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]
-- }}}

-- {{{ Variable definitions

local themes = {
    "blackburn", -- 1
    "copland", -- 2
    "dremora", -- 3
    "holo", -- 4
    "multicolor", -- 5
    "powerarrow", -- 6
    "powerarrow-dark", -- 7
    "rainbow", -- 8
    "steamburn", -- 9
    "vertex", -- 10
}

local chosen_theme = themes[7]
local modkey = "Mod4"
local altkey = "Mod1"
local terminal = os.getenv("TERMINAL") or "kitty"
local vi_focus = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle trough all previous client or just the first -- https://github.com/lcpz/awesome-copycats/issues/274
local editor = os.getenv("EDITOR") or "vim"
local gui_editor = os.getenv("VISUAL") or "code"
local browser = os.getenv("BROWSER") or "firefox"
local scrlocker = os.getenv("SCREEN_LOCK") or "i3lock-fancy-rapid 5 5"
local lamp_entity = "light.desk_lamp"

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    lain.layout.termfair,
    lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({}, 2, function(c)
        c:kill()
    end),
    awful.button({}, 3, function()
        local instance = nil

        return function()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({ theme = { width = dpi(250) } })
            end
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

function unrequire(m)
    package.loaded[m] = nil
    _G[m] = nil
end

Apply_theme = function()
    local filename = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
    naughty.notify({ text = filename })
    beautiful.theme = {}
    unrequire("beautiful")
    beautiful = require("beautiful")
    naughty.notify({ text = tostring(beautiful.init(filename)) })
end

-- }}}

-- {{{ Menu
local myawesomemenu = {
    {
        "hotkeys",
        function()
            return false, hotkeys_popup.show_help
        end,
    },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "edit config GUI", gui_editor .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- Update volume widget on volume change
awesome.connect_signal("volume::update", function()
    beautiful.volume.update()
end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        -- gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    beautiful.at_screen_connect(s)
end)
-- }}}

-- Mouse bindings
-- root.buttons(my_table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))

-- {{{ Key bindings
globalkeys = my_table.join(
    -- Take a screenshot
    awful.key({}, "Print", function()
        awful.spawn("flameshot full -p ~/Pictures/Screenshots")
    end, { description = "Take a screenshot of all monitors", group = "hotkeys" }),
    awful.key({ modkey }, "Print", function()
        awful.spawn("flameshot gui -p ~/Pictures/Screenshots")
    end, { description = "Take a screenshot with GUI", group = "hotkeys" }),

    -- X screen locker
    awful.key({ altkey, "Control" }, "l", function()
        awful.spawn(scrlocker)
    end, { description = "lock screen", group = "hotkeys" }),

    -- Hotkeys
    awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    -- Tag browsing
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function()
        lain.util.tag_view_nonempty(-1)
    end, { description = "view  previous nonempty", group = "tag" }),
    awful.key({ altkey }, "Right", function()
        lain.util.tag_view_nonempty(1)
    end, { description = "view  previous nonempty", group = "tag" }),

    -- Default client focus
    awful.key({ altkey }, "j", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),
    awful.key({ altkey }, "k", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),

    -- By direction client focus
    awful.key({ modkey }, "j", function()
        awful.client.focus.global_bydirection("down")
        if client.focus then
            client.focus:raise()
        end
    end, { description = "focus down", group = "client" }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.global_bydirection("up")
        if client.focus then
            client.focus:raise()
        end
    end, { description = "focus up", group = "client" }),
    awful.key({ modkey }, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then
            client.focus:raise()
        end
    end, { description = "focus left", group = "client" }),
    awful.key({ modkey }, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then
            client.focus:raise()
        end
    end, { description = "focus right", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function()
        awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function()
        awful.screen.focus_relative(-1)
    end, { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey }, "Tab", function()
        if cycle_prev then
            awful.client.focus.history.previous()
        else
            awful.client.focus.byidx(-1)
        end
        if client.focus then
            client.focus:raise()
        end
    end, { description = "cycle with previous/go back", group = "client" }),
    awful.key({ modkey, "Shift" }, "Tab", function()
        if cycle_prev then
            awful.client.focus.byidx(1)
            if client.focus then
                client.focus:raise()
            end
        end
    end, { description = "go forth", group = "client" }),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end, { description = "toggle wibox", group = "awesome" }),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "=", function()
        lain.util.useless_gaps_resize(1)
    end, { description = "increment useless gaps", group = "tag" }),
    awful.key({ altkey, "Control" }, "-", function()
        lain.util.useless_gaps_resize(-1)
    end, { description = "decrement useless gaps", group = "tag" }),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function()
        lain.util.add_tag()
    end, { description = "add new tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "r", function()
        lain.util.rename_tag()
    end, { description = "rename tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Left", function()
        lain.util.move_tag(-1)
    end, { description = "move tag to the left", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Right", function()
        lain.util.move_tag(1)
    end, { description = "move tag to the right", group = "tag" }),
    awful.key({ modkey, "Shift" }, "d", function()
        lain.util.delete_tag()
    end, { description = "delete tag", group = "tag" }),

    -- Standard program
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "b", function()
        if naughty.is_suspended() then
            naughty.resume()
            naughty.notify({ text = "Notification system resumed", ignore_suspend = true })
        else
            naughty.notify({ text = "Notification system suspended", ignore_suspend = true })
            naughty.suspend()
        end
        beautiful.dnd.update()
    end, { description = "Toggle notifiactions", group = "awesome" }),
    awful.key({ altkey, "Shift" }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),
    awful.key({ altkey, "Shift" }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function()
        awful.layout.inc(-1)
    end, { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            client.focus = c
            c:raise()
        end
    end, { description = "restore minimized", group = "client" }),

    -- Dropdown application
    awful.key({ modkey }, "z", function()
        awful.screen.focused().quake:toggle()
    end, { description = "dropdown application", group = "launcher" }),

    -- Widgets popups
    -- awful.key({ altkey, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
    --           {description = "show calendar", group = "widgets"}),
    -- awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --           {description = "show filesystem", group = "widgets"}),
    -- awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    -- {description = "show weather", group = "widgets"}),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn("light -A 1")
    end, { description = "+10%", group = "hotkeys" }),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("light -U 1")
    end, { description = "-10%", group = "hotkeys" }),
    --
    -- Media keys
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn.easy_async("playerctl play-pause", function()
            awesome.emit_signal("media::update")
        end)
    end, { description = "play/pause", group = "media" }),
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn.easy_async("playerctl previous", function()
            awesome.emit_signal("media::update")
        end)
    end, { description = "prev", group = "media" }),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn.easy_async("playerctl next", function()
            awesome.emit_signal("media::update")
        end)
    end, { description = "next", group = "media" }),

    awful.key({ modkey }, "KP_Begin", function()
        awful.spawn.easy_async_with_shell("hass-cli state toggle " .. lamp_entity, function()
            awesome.emit_signal("desklight::update")
        end)
    end, { description = "toggle desklamp", group = "hotkeys" }),

    awful.key({ modkey }, "KP_5", function()
        awful.spawn.easy_async_with_shell("hass-cli state toggle " .. lamp_entity, function()
            awesome.emit_signal("desklight::update")
        end)
    end, { description = "toggle desklamp", group = "hotkeys" }),

    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%+", beautiful.volume.channel), function()
            awesome.emit_signal("volume::update")
        end)
    end, { description = "volume up", group = "media" }),

    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%-", beautiful.volume.channel), function()
            awesome.emit_signal("volume::update")
        end)
    end, { description = "volume down", group = "media" }),

    awful.key({}, "XF86AudioMute", function()
        awful.spawn.easy_async(
            string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel),
            function()
                awesome.emit_signal("volume::update")
            end
        )
    end, { description = "toggle mute", group = "media" }),
    awful.key({ modkey }, "c", function()
        awful.spawn("amixer sset Capture toggle")
    end, { description = "toggle mute", group = "media" }),

    awful.key({ altkey, "Control" }, "m", function()
        awful.spawn(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
        awesome.emit_signal("volume::update")
    end, { description = "volume 100%", group = "media" }),

    awful.key({ altkey, "Control" }, "0", function()
        awful.spawn(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
        beautiful.volume.update()
    end, { description = "volume 0%", group = "media" }),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function()
        awful.spawn.with_shell("xsel | xsel -i -b")
    end, { description = "copy terminal to gtk", group = "hotkeys" }),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function()
        awful.spawn.with_shell("xsel -b | xsel")
    end, { description = "copy gtk to terminal", group = "hotkeys" }),

    -- User programs
    awful.key({ modkey }, "q", function()
        awful.spawn(browser)
    end, { description = "run browser", group = "launcher" }),
    awful.key({ modkey }, "a", function()
        awful.spawn(gui_editor)
    end, { description = "run gui editor", group = "launcher" }),

    -- Default
    --[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
    --]]
    --[[ dmenu
    awful.key({ modkey }, "x", function ()
    awful.layout.suit.floating,
            awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"})
    --]]
    -- alternatively use rofi, a dmenu-like application with more features
    -- check https://github.com/DaveDavenport/rofi for more details
    -- rofi
    awful.key({ modkey }, "d", function()
        awful.spawn("rofi -show")
    end, { description = "show rofi", group = "launcher" }),
    --
    -- Prompt
    awful.key({ modkey }, "r", function()
        awful.screen.focused().mypromptbox:run()
    end, { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "x", function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval",
        })
    end, { description = "lua execute prompt", group = "awesome" })
    --]]
)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client, { description = "magnify client", group = "client" }),
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "w", function(c)
        c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
        { modkey, "Control" },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "maximize", group = "client" }),
    awful.key({ modkey }, "s", function(c)
        c.sticky = not c.sticky
    end, { description = "toggle stickiness", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = { description = "view tag #", group = "tag" }
        descr_toggle = { description = "toggle tag #", group = "tag" }
        descr_move = { description = "move focused client to tag #", group = "tag" }
        descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
    end
    globalkeys = my_table.join(
        globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
                local all_clients = screen.clients
            end
        end, descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        },
    },

    -- Titlebars
    {
        rule_any = { type = { "dialog", "normal" } },
        properties = { titlebars_enabled = false },
    },

    -- Set Firefox to always map on the first tag on screen 1.
    {
        rule = { class = "Firefox" },
        properties = { screen = 1, tag = awful.util.tagnames[1] },
    },

    {
        rule = { class = "Gimp", role = "gimp-image-window" },
        properties = { maximized = true },
    },
    {
        rule_any = {
            class = { "leagueclientux.exe", "riotclientux.exe", "leagueclient.exe" },
        },
        properties = { floating = true, placement = awful.placement.centered },
    },
    {
        rule = { class = "league of legends.exe" },
        properties = { fullscreen = true },
    },
    {
        rule = { class = "Firefox" },
        except = { instance = "Navigator" },
        properties = { floating = true },
    },
    {
        rule = { instance = "wpg" },
        properties = { floating = true, placement = awful.placement.centered, above = true, ontop = true },
    },
    {
        rule = { class = "R_x11" },
        properties = {
            floating = true,
            focus = false,
            placement = awful.placement.no_overlap + awful.placement.top_right,
            above = true,
            ontop = true,
        },
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- if not c.maximized and not c.fullscreen then
    --     c.shape = function(cr, w, h)
    --         gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
    --     end
    -- end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- client.connect_signal("property::fullscreen", function(c)
--     if not c.fullscreen then
--         c.shape = function(cr, w, h)
--             gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
--         end
--     else
--         c.shape = gears.shape.rectangle
--     end
-- end)
--
-- client.connect_signal("property::maximized", function(c)
--     if not c.maximized then
--         c.shape = function(cr, w, h)
--             gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
--         end
--     else
--         c.shape = gears.shape.rectangle
--     end
-- end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 2, function()
            c:kill()
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = dpi(16) }):setup({
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        {
            -- Middle
            {
                -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        {
            -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

tobottom = function()
    screen[1].mywibox.position = "bottom"
end

function tprint(tbl, indent)
    if not indent then
        indent = 0
    end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if type(k) == "number" then
            toprint = toprint .. "[" .. k .. "] = "
        elseif type(k) == "string" then
            toprint = toprint .. k .. "= "
        end
        if type(v) == "number" then
            toprint = toprint .. v .. ",\r\n"
        elseif type(v) == "string" then
            toprint = toprint .. '"' .. v .. '",\r\n'
        elseif type(v) == "table" then
            -- toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
            toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
        else
            toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

naughty.config.notify_callback = function(args)
    if args.app_name == "Telegram Desktop" then
        args.actions = nil
    end
    if args.actions ~= nil then
        args.timeout = args.timeout * 10
    end
    return args
end

-- Set mouse to center of primary screen
mouse.coords({
    x = screen.primary.geometry.x + screen.primary.geometry.width // 2,
    y = screen.primary.geometry.y + screen.primary.geometry.height // 2,
}, true)

-- possible workaround for tag preservation when switching back to default screen:
-- https://github.com/lcpz/awesome-copycats/issues/251
-- }}}
-- }}}
-- }}}
