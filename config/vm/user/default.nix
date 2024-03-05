{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../shared/home.nix
    ./programs.nix
  ];
}
