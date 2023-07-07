{ config, pkgs, nixpkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
  };

  home.file = {
    "${config.xdg.configHome}/nvim" = {
      source = ../../../dotfiles/nvim;
    };
  };
}
