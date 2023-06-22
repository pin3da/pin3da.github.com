---
title: "Framework"
date: 2023-06-11T18:33:51+02:00
draft: true
---

Installing i3wm + Fedora 38 on Framework 13th

## Official guideline

https://guides.frame.work/Guide/Fedora+38+Installation+on+the+Framework+Laptop+13/165

## Brightness

Update i3config

```
# Screen brightness controls
bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +5%
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-
```

## Mapping keys

Update i3config

```
exec --no-startup-id xmodmap ~/.xmodmaps
```

```
# ~/.xmodmaps
remove Lock = Caps_Lock
add Lock = Escape
keysym Caps_Lock = Escape
keysym Escape = Caps_Lock
```

## Gnome flashback + i3

This is probably the easiest way to fix most of the UI stuff

https://github.com/regolith-linux/i3-gnome-flashback

## Middle click

`gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map "lmr"`
