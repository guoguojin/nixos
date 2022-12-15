{ config, pkgs, nixpkgs, ... }:

{
  services = {
    udiskie = {
      automount = true;
      notify = true;
    };

    gpg-agent = {
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    dunst = {
      enable = true;
      settings = {
        global = {
          width = "(300, 600)";
          height = 50;
          offset = "(10, 50)";
          origin = "top-right";
          font = "Cantarell 18";
          sort = true;
          follow = "mouse";
          show_indicators = true;
          word_wrap = true;
          markup = "full";
          format = "<b>%s</b>\n%b";
          alignment = "left";
          icon_position = "left";
        };
        urgency_low = {
          background = "#ffd5cd";
          foreground = "#121212";
          frame_colour = "#181A20";
          timeout = 5;
        };
        urgency_normal = {
          background = "#121212";
          foreground = "#ffd5cd";
          frame_colour = "#181A20";
          timeout = 10;
        };
        urgency_critical = {
          background = "#121212";
          foreground = "#ffd5cd";
          frame_colour = "#181A20";
          timeout = 0;
        };
      };
    };
  };
}