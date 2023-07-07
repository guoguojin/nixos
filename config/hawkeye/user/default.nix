{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../shared
    ./i3status-rust.nix
    ../../shared/programs/neovim.nix
  ];
}
