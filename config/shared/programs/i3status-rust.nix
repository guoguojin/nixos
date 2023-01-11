{ config, pkgs, nixpkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        icons = "awesome6";
        settings = {
          theme = {
            name = "slick";
          };
        };
        blocks = [
          # Information about what blocks are available can be found:
          # https://github.com/greshake/i3status-rust/blob/v0.22.0/doc/blocks.md
          {
            block = "weather";
            service = {
              name = "openweathermap";
              units = "metric";
            };
            autolocate = true;
            format = "{weather} @ {location} {temp}, {wind} m/s {direction}";
          }
          {
            block = "music";
            player = "spotify";
            buttons = [ "play" "next" ];
            on_collapsed_click = "spotify";
          }
          {
            block = "backlight";
            device = "intel_backlight";
          }
          {
            block = "battery";
            interval = 10;
            format = "{percentage:6#100} {percentage} {time}";
          }
          {
            block = "taskwarrior";
            interval = 60;
            format = "{count} open tasks ({filter_name})";
            format_singular = "{count} open task ({filter_name})";
            format_everything_done = "All done!";
            warning_threshold = 10;
            critical_threshold = 20;
            filters = [
              {
                name = "today";
                filter = "+PENDING +OVERDUE or +DUETODAY";
              }
            ];
          }
          {
            block = "networkmanager";
            on_click = "nm-connection-editor";
            interface_name_exclude = ["docker\\d+"];
          }
          {
            block = "external_ip";
            format = "{ip} {region_code} {country}";
          }
          { 
            block = "time"; 
            format = "%a %d/%m %R";
            interval = 60; 
          }
        ];
      };
      bottom = {
        icons = "awesome6";
        settings = {
          theme = {
            name = "solarized-dark";
          };
        };
        blocks = [
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used}/{mem_total}({mem_used_percents})";
            format_swap = "{swap_used}/{swap_total}({swap_used_percents})";
          }
          {
            block = "cpu";
            interval = 1;
            format = "{barchart} {utilization} {frequency}";
          }
          {
            block = "temperature";
            collapsed = false;
            interval = 10;
            chip = "*-isa-*";
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          {
            block = "sound";
          }
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "disk_space";
            path = "/home/tanq/code";
            alias = "code";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "uptime";
          }
        ];
      };
    };
  };
}
