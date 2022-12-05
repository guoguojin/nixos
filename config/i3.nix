# Configuration for installing i3wm

{ config, pkgs, ... }:

{
    services.xserver.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [ 
            polkit_gnome
            autotiling
            dmenu
            i3blocks
            i3lock
            feh
            variety
            dunst
            picom
            i3-auto-layout
            i3-layout-manager
            rofi
            gmrun
            i3status-rust 
            blueberry
            numlockx
            pasystray
            xfce.catfish
            pavucontrol
            xorg.xkill
            pcmanfm
            scrot
            playerctl
            light
            betterlockscreen
            xautolock
            udiskie
            unclutter
        ];
    };
}