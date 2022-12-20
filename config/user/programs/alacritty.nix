{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "alacritty";
        };
        window = {
          decorations = "none";
          opacity = 0.6;
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };
        scrolling.history = 100000;
        font = {
          normal = {
            family = "CaskaydiaCove Nerd Font Mono";
            style = "Light";
          };
          size = 8.0;
        };
        colors = {
          primary = {
            background = "0x011627";
            foreground = "0xd6deeb";
          };
          
          cursor = {
            text =   "0xffffff";
            cursor = "0x7e57c2";
          };
          normal = {
            black =   "0x000000";
            red =     "0xef5350";
            green =   "0x22da6e";
            yellow =  "0xaddb67";
            blue =    "0x82aaff";
            magenta = "0xc792ea";
            cyan =    "0x21c7a8";
            white =   "0xffffff";
          };
          bright = {
            black =   "0x575656";
            red =     "0xef5350";
            green =   "0x22da6e";
            yellow =  "0xffeb95";
            blue =    "0x82aaff";
            magenta = "0xc792ea";
            cyan =    "0x7fdbca";
            white =   "0xffffff";
          };
        };
        selection.save_to_clipboard = true;
        cursor.style = "Block";
        mouse.hide_when_typing = true;
        mouse_bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
      };
    };
  };
}