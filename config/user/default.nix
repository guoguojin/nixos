{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ./home.nix
    ./programs.nix
    ./services.nix
    ./i3.nix
  ];
}
