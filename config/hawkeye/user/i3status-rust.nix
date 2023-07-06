{ config, pkgs, nixpkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        icons = "awesome6";
        settings = {
          theme = {
            theme = "slick";
          };
        };
        blocks = [
          # Information about what blocks are available can be found:
          # https://github.com/greshake/i3status-rust/blob/v0.22.0/doc/blocks.md
          {
            block = "focused_window";
          }
          {
            block = "weather";
            format = " $icon  $weather @ $location $temp, $wind m/s $direction ";
            autolocate = true;
            service = {
              name = "openweathermap";
              units = "metric";
              city_id = "2652618";
            };
          }
          {
            block = "music";
            player = "spotify";
            click = [
              {
                button = "left";
                action = "play_pause";
              }
              {
                button = "up";
                action = "volume_up";
              }
              {
                button = "down";
                action = "volume_down";
              }
              {
                button = "forward";
                action = "seek_forward";
              }
              {
                button = "back";
                action = "seek_backward";
              }
            ];
          }
          {
            block = "taskwarrior";
            critical_threshold = 20;
            format = " $count open tasks ($filter_name) ";
            format_everything_done = " $icon  All done! ";
            format_singular = " $icon  $count open task ($filter_name) ";
            interval = 60;
            warning_threshold = 10;
            data_location = "/home/tanq/.local/share/task";
            filters = [
              {
                name = "today";
                filter = "+PENDING +OVERDUE +DUETODAY";
              }
            ];
          }
          {
            block = "net";
            format = " $icon  ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) $signal_strength $ip ";
            device = "wlp3s0";
            click = [{
              button = "left";
              cmd = "nm-connection-editor";
            }];
          }
          { 
            block = "time"; 
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60; 
          }
        ];
      };
      bottom = {
        icons = "awesome6";
        settings = {
          theme = {
            theme = "slick";
          };
        };
        blocks = [
          {
            block = "memory";
            format = "$mem_used/$mem_total($mem_used_percents)";
            format_alt = "$swap_used/$swap_total($swap_used_percents)";
          }
          {
            block = "cpu";
            interval = 1;
            format = "$barchart $utilization $frequency";
          }
          {
            block = "temperature";
            interval = 10;
          }
          {
            block = "load";
            interval = 1;
            format = " $icon  1 min avg. $1m.eng(w:4) ";
          }
          {
            block = "sound";
          }
          {
            block = "disk_space";
            path = "/";
            format = "$icon  / $used/$total";
            info_type = "available";
            alert_unit = "GB";
            interval = 60;
          }
          {
            block = "uptime";
          }
        ];
      };
    };
  };
}
