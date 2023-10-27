{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ./user
  ];
  # Machine specific user space file mappings
  home.file = {
    "${config.xdg.configHome}/lvim" = {
      source = ../../dotfiles/lvim;
    };
  };

  # Machine specific user space packages
  home.packages = with pkgs; [
    logseq
    anytype
    zoom-us
  ];
}
