{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../user/home.nix
    ./programs.nix
    ../../user/services.nix
    ../../user/i3.nix
  ];
}
