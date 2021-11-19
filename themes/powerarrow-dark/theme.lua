--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local function random_wallpaper(s)
    -- awful.spawn.with_shell("bash " .. os.getenv("HOME") .. "/bin/randwall")
    -- awful.spawn.easy_async("bash " .. os.getenv("HOME") .. "/bin/randwall")
    awful.spawn.once("randwall")
end

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = random_wallpaper
-- theme.wallpaper                                 = theme.dir .. "/wall.png"
-- theme.font                                      = "Terminus 9"
theme.font                                      = "FiraCode Nerd Font 13"
-- theme.font                                      = "SauceCodePro Nerd Font 9"
theme.opacity                                   = "CC"
theme.fg_normal                                 = "#C0C5CE"
theme.fg_focus                                  = "#EDF3FE"
theme.fg_urgent                                 = "#ec5f67"
theme.bg_normal                                 = "#1B2B35" .. "FF"-- .. "FF" -- theme.opacity
theme.bg_focus                                  = "#2B3B45" .. theme.opacity
theme.bg_widget                                 = "#00FFFF" .. "11" -- theme.opacity -- theme.bg_normal .. theme.opacity
theme.bg_widget_alt                             = "#FFFF00" .. "11" -- theme.bg_normal .. theme.opacity
theme.bg_systray                                = theme.bg_normal
theme.bg_urgent                                 = theme.bg_normal
theme.border_width                              = dpi(1)
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.fg_normal
theme.border_marked                             = "#ec5f67"

theme.tasklist_bg_focus                         = theme.bg_widget_alt
theme.tasklist_bg_normal                        = theme.bg_widget -- .. "00" -- full transparency

theme.taglist_bg_focus                          = theme.bg_widget_alt
theme.taglist_bg_normal                         = theme.bg_widget -- .. "00" -- full transparency
theme.taglist_bg_occupied                       = theme.bg_widget -- .. "00" -- full transparency
theme.taglist_bg_empty                          = theme.bg_widget -- .. "00" -- full transparency

theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.layout_centerwork                         = theme.dir .. "/icons/centerwork.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(3)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    followtag = true,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_widget
    }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- MPD
local musicplr = awful.util.terminal .. " -title Music -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ "Mod4" }, 1, function () awful.spawn(musicplr) end),
    awful.button({ }, 1, function ()
        os.execute("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        os.execute("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        os.execute("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(theme.widget_music)
        end

        widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
    end
})

-- MEM
-- local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. mem_now.used .. "MB "))
    end
})

-- CPU
-- local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
-- local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    tempfile = "/sys/devices/virtual/thermal/thermal_zone8/temp",
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. coretemp_now .. "糖 "))
    end
})

-- weather
-- city_id = 3128760
--
local weather = lain.widget.weather({
    APPID = "7bb02484397fc49b0dcffe9d53744616",
    city_id = 3128760,
    settings = function()
        --descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        --widget:set_markup(markup.font(theme.font, " " .. descr .. " " .. units .. "°C "))
        widget:set_markup(markup.font(theme.font, "" .. units .. "糖 "))
    end,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_widget_alt
    }
})

-- / fs
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
-- -- commented because it needs Gio/Glib >= 2.54
-- theme.fs = lain.widget.fs({
--     notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
--     settings = function()
--         widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
--     end
-- })
--

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})
theme.volume.widget:buttons(awful.util.table.join(
                               awful.button({}, 4, function ()
                                     awful.util.spawn("amixer set Master 1%+")
                                     theme.volume.update()
                               end),
                               awful.button({}, 5, function ()
                                     awful.util.spawn("amixer set Master 1%-")
                                     theme.volume.update()
                               end)
))

-- Net
-- local neticon = wibox.widget.imagebox(theme.widget_net)
-- local net = lain.widget.net({
--     settings = function()
--         widget:set_markup(markup.font(theme.font,
--                           markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
--                           .. " " ..
--                           markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
--     end
-- })

-- Separators
local spr     = wibox.widget.textbox(' ')
-- local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
-- local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)
local arrl_dl = separators.arrow_left(theme.bg_widget_alt, theme.bg_widget)
local arrl_ld = separators.arrow_left(theme.bg_widget, theme.bg_widget_alt)

local systray = wibox.widget.systray()
systray.opacity = 0.2

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper(s)
    end
    -- if type(wallpaper) == "function" then
        -- wallpaper = wallpaper(s)
    -- end
    -- gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
    s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = awful.util.tasklist_buttons,
    layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 24,
                thickness     = 1,
                color         = '#777777',
                widget        = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        spacing = 1,
        layout  = wibox.layout.fixed.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        -- {
        --     wibox.widget.base.make_widget(),
        --     forced_height = 5,
        --     id            = 'background_role',
        --     widget        = wibox.container.background,
        -- },
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            -- margins = 1,
            id            = 'background_role',
            widget  = wibox.container.background
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id('clienticon')[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
}

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(26), bg = theme.bg_normal .. theme.opacity , fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            wibox.container.background(spr, theme.bg_widget),
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            keyboardlayout,
            spr,
            arrl_ld,
            wibox.container.background(mpdicon, theme.bg_focus),
            wibox.container.background(theme.mpd.widget, theme.bg_focus),
            arrl_dl,
            wibox.container.background(volicon, theme.bg_widget),
            wibox.container.background(theme.volume.widget, theme.bg_widget),
            --arrl_ld,
            --wibox.container.background(mailicon, theme.bg_widget_alt),
            --wibox.container.background(theme.mail.widget, theme.bg_widget_alt),
            arrl_ld,
            -- wibox.container.background(memicon, theme.bg_widget_alt),
            wibox.container.background(mem.widget, theme.bg_widget_alt),
            arrl_dl,
            -- cpuicon,
            wibox.container.background(cpu.widget, theme.bg_widget),
            arrl_ld,
            -- wibox.container.background(tempicon, theme.bg_widget_alt),
            wibox.container.background(temp.widget, theme.bg_widget_alt),
            -- arrl_ld,
            -- wibox.container.background(fsicon, theme.bg_widget_alt),
            -- wibox.container.background(theme.fs.widget, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(baticon, theme.bg_widget),
            wibox.container.background(bat.widget, theme.bg_widget),
            arrl_ld,
            -- wibox.container.background(neticon, theme.bg_widget_alt),
            -- wibox.container.background(net.widget, theme.bg_widget_alt),
            wibox.container.background(spr, theme.bg_widget_alt),
            wibox.container.background(weather.icon, theme.bg_widget_alt),
            wibox.container.background(weather.widget, theme.bg_widget_alt),
            -- wibox.container.background(net.widget, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(clock, theme.bg_widget),
            wibox.container.background(spr, theme.bg_widget),
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_widget_alt),
        },
    }
end

return theme
