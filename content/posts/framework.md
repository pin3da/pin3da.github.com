---
title: "Using Fedora on a Framework Laptop"
date: 2023-06-23T18:33:51+02:00
draft: false
---

I recently switched to a [Framework](https://frame.work/) laptop. They suggest Fedora as their linux distro, so I decided to give it a try despite being a long-time Debian user. This post aims to document some of the issues I had and how to solve them.

## Official guideline

The framework team has amazing support. Their documentation just worked out of the box.

https://guides.frame.work/Guide/Fedora+38+Installation+on+the+Framework+Laptop+13/165

The only small change I added was the tap-buttom-map configuration in Gnome to something sensible: 

`gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map "lmr"`

## Installing i3

I've also been using [i3 wm](https://i3wm.org/) for a long time. This worked pretty well, specially if you are not resource constrained and can run it on top of Gnome (e.g. using [gnome flashback](https://github.com/nmakel/i3-gnome)).

This time it didn't work for me, since the new Gnome settings work on [Wayland](https://wayland.freedesktop.org/) and i3 is not compatible with it.

## Installing sway

Fortunatelly, there is a drop-in replacement: [Sway](https://swaywm.org/). It also happens to be that Fedora supports an [official spin](https://fedoraproject.org/spins/sway/) with it.

I re-installed Fedora using the Sway spin and it almost worked out of the box.

### Small problems

Note: In order to update the config, you can copy the default config (`/etc/sway/config`) to `~/.config/sway/config` and edit it there.

#### 1. Scaling
For some reason the default scaling is set to 2.0, which is too much. To solve it you need to get the name of your display by doing:

 `swaymsg -t get_outputs`

 You will see the name of the output (e.g. "DP-3") and the current scaling factor.

 Then you can update the scaling to a reasonable value in the sway config:
 
 `output eDP-1 scale 1.25`

#### 2. Missing fonts

Some of the icons were broken, I installed fontawesome `sudo dnf install fontawesome-fonts` which fixed most of the issues. For the other icons I went to the waybar configuration and changed them.

#### 3. Touchpad

It was not working by default. The solution was very similar to the scaling issue. First ran `swaymsg -t get_inputs`, look the name of the touchpad and then add a new entry to the sway config:

```
input "<ID from prev command>_Touchpad"  {
      tap enabled
      tap_button_map lmr
}
```

## Thoughts

Overall I'm very happy with Fedora + Sway spin. It is easy to configure and it works well with the Framework hardware.
