{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    i3status-rust = {
      enable = true;
      # bars = {
      #   top = {
      #     blocks = [
      #       {
      #         block = "time";
      #         interval = 60;
      #         format = "%a %b %d %H:%M:%S";
      #       }
      #     ];
      #   };
      # };
    };
  };
}
