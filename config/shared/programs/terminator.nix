{ config, pkgs, nixpkgs, ... }:

{
  programs.terminator = {
    enable = true;
    config = {
      global_config.title_hide_sizetext = true;
      layouts = {
        default = {
          child1 = {
            parent = "window0";
            type = "Terminal";
          };
          window0 = {
            parent = "";
            type = "Window";
          };
        };
      };
      profiles = {
        default = {
          allow_bold = false;
          background_color = "#2e3436";
          background_darkness = 0.8;
          background_type = "transparent";
          copy_on_selection = true;
          cursor_color = "#aaaaaa";
          font = "CaskaydiaCove Nerd Font SemiLight 12";
          foreground_color = "#ffffff";

          palette = "#2e3436:#ef5350:#80cbc4:#ffeb95:#82aaff:#c792ea:#addb67:#d3d7cf:#555753:#ef5350:#80cbc4:#ffeb95:#82aaff:#c792ea:#addb67:#eeeeec";
          scroll_on_output = true;
          scrollback_infinite = true;
          scrollbar_position = "hidden";
          show_titlebar = false;
          use_system_font = false;
        };
      };
    };
  };
}