{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../shared/home.nix
    ../../shared/programs.nix
    ../../shared/services.nix
    ../../shared/i3.nix
  ];
}
