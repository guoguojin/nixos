{ config, lib, pkgs, nixpkgs, ... }:

let mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      fonts = {
        names = ["SF Pro Display"];
        style = "Light";
        size = 11.0;
      };

      defaultWorkspace = "workspace number 1";

      focus = {
        followMouse = false;
        mouseWarping = false;
      };
      
      gaps = {
        inner = 5;
        outer = 5;
      };

      terminal = "alacritty";

      startup = [
        { command = "telegram-desktop -startintray"; notification = false; }
        { command = "slack -u"; notification = false; }
        { command = "whatsapp-for-linux"; notification = false; }
        { command = "udiskie --tray"; notification = false; }
        { command = "udiskie-mount -a"; notification = false; }
        { command = "unclutter"; }
        { command = "autotiling"; notification = false; always = true; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; notification = false; }
        { command = "variety"; notification = false; }
        { command = "dropbox"; notification = false; }
        { command = "autorandr -c"; notification = false; }
      ];

      assigns = {
        "10" = [ 
          { class = "Whatsapp-for-linux";}
          { class = "TelegramDesktop"; }
          { class = "Slack"; }
        ];
      };

      floating = {
        criteria = [
          { class = "Blueberry.py"; }
          { class = "Galculator"; }
          { class = "qt5ct|Lxappearance"; }
          { class = "^Skype$"; }
          { class = "Xfce4-appfinder"; }
          { class = "Xfce4-taskmanager"; }
          { title = "Copying"; }
          { title = "Deleting"; }
          { title = "Moving"; }
          { title = "^Terminator Preferences$"; }
          { window_role = "pop-up"; }
          { window_role = "^Preferences$"; }
          { window_role = "setup"; }
        ];
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+q" = "kill";
        "Mod1+F1" = "exec --no-startup-id xfce4-appfinder;focus";
        "Mod1+F2" = "exec --no-startup-id gmrun";
        "${mod}+F11" = "exec --no-startup-id rofi -show run";
        "${mod}+F12" = "exec --no-startup-id rofi -show drun";
        "control+Shift+Escape" = "exec --no-startup-id xfce4-taskmanager;focus";
        "control+mod1+m" = "exec --no-startup-id xfce4-settings-manager";
        "control+mod1+c" = "exec --no-startup-id catfish;focus";
        "${mod}+F2" = "exec brave --profile-directory=\"Default\";focus";
        "${mod}+Shift+F2" = "exec firefox; focus";
        "${mod}+F3" = "exec code; focus";
        "${mod}+Shift+Return" = "exec pcmanfm;focus";
        "Print" = "exec --no-startup-id scrot \'%Y-%m-%d-%s_screenshot_$wx$h.jpg\' -e \'mv $f $$(xdg-user-dir PICTURES)/screenshots\'";
        "Control+Print" = "exec --no-startup-id xfce4-screenshooter";
        
        "XF86AudioRaiseVolume" = "exec --no-startup-id \"amixer -D pulse sset Master \'5%+\'\"";
        "XF86AudioLowerVolume" = "exec --no-startup-id \"amixer -D pulse sset Master \'5%-\'\"";
        "XF86AudioMute" = "exec --no-startup-id \"amixer -D pulse set Master toggle\"";
        "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
        "XF86AudioNext" = "exec --no-startup-id playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
        "XF86AudioStop" = "exec --no-startup-id playerctl stop";

        "XF86MonBrightnessUp" = "exec --no-startup-id sh -c \"light -A 10 && notify-brightness\""; # increase screen brightness
        "XF86MonBrightnessDown" = "exec --no-startup-id sh -c \"light -U 10 && notify-brightness\""; # decrease screen brightness

        "${mod}+Mod1+Right" = "move workspace to output right";
        "${mod}+Mod1+Left" = "move workspace to output left";
        "${mod}+Mod1+Down" = "move workspace to output down";
        "${mod}+Mod1+Up" = "move workspace to output up";
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
          fonts = {
            names = [ "SF Pro Display" "FontAwesome" ];
            size = 13.0;
          };
          trayOutput = "primary";
          colors = {
            background = "#011627";
            statusline = "#eeeeee";
            separator = "666666";

            focusedWorkspace = {
              border = "#a9a9a9";
              background = "#018eeb";
              text = "#eeeeee";
            };

            inactiveWorkspace = {
              border = "#a9a9a9";
              background = "#222222";
              text = "#a9a9a9";
            };

            urgentWorkspace = {
              border = "#a9a9a9";
              background = "#d42121";
              text = "#ffffff";
            };
          };
        }
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
          workspaceButtons = false;
          fonts = {
            names = [ "SF Pro Display" "FontAwesome" ];
            size = 13.0;
          };
          trayOutput = "none";
          colors = {
            background = "#011627";
            statusline = "#eeeeee";
            separator = "666666";
          };
        }
      ];
    };

    extraConfig = ''
set $mode_gaps Gaps: (o) outer, (i) inner
set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
bindsym ${mod}+Shift+g mode "$mode_gaps"

mode "$mode_gaps" {
  bindsym o      mode "$mode_gaps_outer"
  bindsym i      mode "$mode_gaps_inner"
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

mode "$mode_gaps_inner" {
  bindsym plus  gaps inner current plus 5
  bindsym minus gaps inner current minus 5
  bindsym 0     gaps inner current set 0

  bindsym Shift+plus  gaps inner all plus 5
  bindsym Shift+minus gaps inner all minus 5
  bindsym Shift+0     gaps inner all set 0

  bindsym Return mode "default"
  bindsym Escape mode "default"
}
mode "$mode_gaps_outer" {
  bindsym plus  gaps outer current plus 5
  bindsym minus gaps outer current minus 5
  bindsym 0     gaps outer current set 0

  bindsym Shift+plus  gaps outer all plus 5
  bindsym Shift+minus gaps outer all minus 5
  bindsym Shift+0     gaps outer all set 0

  bindsym Return mode "default"
  bindsym Escape mode "default"
}

bindsym ${mod}+Escape mode "$mode_system"
# bindsym control+mod1+Delete mode "$mode_system"

set $mode_system System (k) lock, (l) logout, (u) suspend, (h) hibernate, (r) reboot, (s) shutdown
mode "$mode_system" {
  bindsym k exec --no-startup-id ~/.config/i3/scripts/i3exit.sh lock, mode "default"
  bindsym l exec --no-startup-id ~/.config/i3/scripts/i3exit.sh logout, mode "default"
  bindsym u exec --no-startup-id ~/.config/i3/scripts/i3exit.sh suspend, mode "default"
  bindsym h exec --no-startup-id ~/.config/i3/scripts/i3exit.sh hibernate, mode "default"
  bindsym r exec --no-startup-id ~/.config/i3/scripts/i3exit.sh reboot, mode "default"
  bindsym s exec --no-startup-id ~/.config/i3/scripts/i3exit.sh shutdown, mode "default"

  # back to normal: Enter or Escape
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

#####################################################################################################################
#################                          variety for your wallpapers                              #################
#####################################################################################################################

mode "$variety" {
  #Variety keybindings mod1 = ALT
  # trash wallpaper
  bindsym t exec --no-startup-id variety -t, mode "default"
  # next wallpaper
  bindsym n exec --no-startup-id variety -n, mode "default"
  # previous wallpaper
  bindsym p exec --no-startup-id variety -p, mode "default"
  # favorite wallpaper
  bindsym f exec --no-startup-id variety -f, mode "default"
  # pause wallpaper
  bindsym Up exec --no-startup-id variety --pause, mode "default"
  # resume wallpaper
  bindsym Down exec --no-startup-id variety --resume, mode "default"

  bindsym Return mode "default"
  bindsym Escape mode "default"
}

bindsym mod1+Shift+v mode "$variety"
set $variety Variety: (n)ext, (p)revious, (f)avourite, (t)rash,  pause,  resume
    '';
  };
}

