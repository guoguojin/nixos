{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../shared/home.nix
    ./programs.nix
    ../../shared/services.nix
    ../../shared/i3.nix
  ];
}
