--[[

Powerarrow Dark Awesome WM theme
github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local naughty = require("naughty")
local nconf = naughty.config
local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
theme.wallpaper                                 = os.getenv("HOME") .. "/Pictures/Wallpapers/forest.jpg"
theme.font                                      = "FiraCode Nerd Font 13"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#9A9FF1"
theme.fg_urgent                                 = "#EA6F81"
theme.bg_normal                                 = "#011626"
theme.bg_focus                                  = "#213646"
theme.bg_widget                                 = theme.bg_normal
theme.bg_widget_alt                             = theme.bg_focus
theme.bg_systray                                = theme.bg_widget_alt
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.fg_normal
theme.border_marked                             = "#CC9393"
theme.notification_icon_size                    = dpi(128)
theme.border_radius                             = dpi(10)

theme.hotkeys_bg 	= theme.bg_normal
theme.hotkeys_fg 	= theme.fg_normal
theme.hotkeys_border_width 	= theme.border_width
theme.hotkeys_border_color 	= theme.border_focus
theme.hotkeys_modifiers_fg = theme.fg_focus
theme.hotkeys_shape 	= function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, theme.border_radius)
end

theme.hotkeys_font 	= string.gsub(theme.font, "\\d+", "") .. "Mono 11"
theme.hotkeys_description_font 	= string.gsub(theme.font, "\\d+", "") .. " 9"

theme.tasklist_bg_focus                         = theme.bg_widget_alt
theme.tasklist_bg_normal                        = theme.bg_widget

theme.taglist_bg_focus                          = theme.bg_widget_alt
theme.taglist_bg_normal                         = theme.bg_widget
theme.taglist_bg_occupied                       = theme.bg_widget
theme.taglist_bg_empty                          = theme.bg_widget

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

nconf.defaults.border_width = 0
nconf.defaults.border_color = theme.border_focus
nconf.defaults.margin = dpi(16)
nconf.defaults.shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, theme.border_radius)
end
nconf.defaults.timeout = 5
nconf.padding = dpi(16)
nconf.presets.critical.bg = theme.bg_urgent
nconf.presets.critical.fg = theme.fg_urgent
nconf.presets.low.border_color = theme.border_normal
nconf.presets.low.bg = theme.bg_normal
nconf.presets.normal.bg = theme.bg_focus
nconf.defaults.icon_size = 64
nconf.spacing = 8

theme.notification_max_width = dpi(500)

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()
keyboardlayout.widget.font = theme.font

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
        bg   = theme.bg_widget,
        icon_size = dpi(128),
        margin = dpi(10),
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, theme.border_radius)
        end
    }
})

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
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local temp = lain.widget.temp({
    tempfile = "/sys/devices/virtual/thermal/thermal_zone8/temp",
    settings = function()
        widget:set_markup(markup.font(theme.font, "  " .. coretemp_now .. "糖 "))
    end
})

-- weather
local weather = lain.widget.weather({
    APPID = "7bb02484397fc49b0dcffe9d53744616",
    city_id = 3128760,
    settings = function()
        -- descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        --widget:set_markup(markup.font(theme.font, " " .. descr .. " " .. units .. "°C "))
        -- widget:set_markup(markup.font(theme.font, "" .. units .. "糖 "))
        widget:set_markup(markup.font(theme.font, "" .. units .. "<span font_size='small' font_stretch='condensed'>°C</span> "))
    end,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_widget_alt,
        icon_size = dpi(128),
        margin = dpi(10),
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, theme.border_radius)
        end
    }
})

-- Battery
local baticon =  wibox.widget.imagebox("#FF0000")

function baticon:set_image_colored(image)
    self:set_image(gears.color.recolor_image(image, theme.fg_normal))
end

local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image_colored(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image_colored(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image_colored(theme.widget_battery_low)
            else
                baticon:set_image_colored(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image_colored(theme.widget_ac)
        end
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        local vol_level = tonumber(volume_now.level)
        if vol_level == nil then
            vol_level = ""
        end
        local volicon
        if volume_now.status == "off" or vol_level == nil then
            volicon = "ﱝ"
        elseif vol_level == 0 then
            volicon = "奄"
        elseif vol_level <= 50 then
            volicon = "奔"
        else
            volicon = "墳"
        end

        widget:set_markup(markup.font(theme.font, " " .. volicon .. " " .. vol_level .. "% "))
    end
})
theme.volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function ()
        awful.spawn.easy_async("amixer set Master toggle",
            function() theme.volume.update() end)
    end),
    awful.button({}, 3, function ()
        awful.spawn.easy_async("switch-audio",
            function(stdout)
                require('naughty').notify{text = stdout}
                theme.volume.update()
            end)
    end),
    awful.button({}, 4, function ()
        awful.spawn.easy_async("amixer set Master 1%+",
            function() theme.volume.update() end)
    end),
    awful.button({}, 5, function ()
        awful.spawn.easy_async("amixer set Master 1%-",
            function() theme.volume.update() end)
    end)
))

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_widget_alt, theme.bg_widget)
local arrl_ld = separators.arrow_left(theme.bg_widget, theme.bg_widget_alt)

local arrd = separators.arrow_right(theme.bg_widget_alt, "alpha")

local arrl_dl_f = separators.arrow_left("alpha", theme.bg_widget)
local arrl_ld_f = separators.arrow_left("alpha", theme.bg_widget_alt)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal, argname = "--name %s" })

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
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
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(26, s), bg = "alpha", fg = theme.fg_normal })

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
        {
            -- Middle widget
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist,
            arrd
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            arrl_ld_f,
            wibox.container.background(spr, theme.bg_widget_alt),
            wibox.container.background(wibox.widget.systray(), theme.bg_widget_alt),
            wibox.container.background(spr, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(theme.volume.widget, theme.bg_widget),
            arrl_ld,
            wibox.container.background(mem.widget, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(cpu.widget, theme.bg_widget),
            arrl_ld,
            wibox.container.background(temp.widget, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(baticon, theme.bg_widget),
            wibox.container.background(bat.widget, theme.bg_widget),
            arrl_ld,
            wibox.container.background(spr, theme.bg_widget_alt),
            wibox.container.background(weather.icon, theme.bg_widget_alt),
            wibox.container.background(weather.widget, theme.bg_widget_alt),
            arrl_dl,
            wibox.container.background(clock, theme.bg_widget),
            wibox.container.background(spr, theme.bg_widget),
            arrl_ld,
            wibox.container.background(s.mylayoutbox, theme.bg_widget_alt),
        },
    }
end

return theme
