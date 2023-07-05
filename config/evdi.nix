# Configuration file for adding displaylink drivers and the evdi kernel module 
# required to drive the displaylink devices.

{ config, lib, pkgs, ... }:

{
  # make sure the kernel module is loaded in hardware-configuration.nix
  # boot.kernelModules = [ "evdi" ];

  # temporary workaround for evdi drivers with linux 6.0
  boot.kernelPackages = pkgs.linuxPackages_latest.extend (self: super: {
    evdi = super.evdi.overrideAttrs (o: rec {
      src = pkgs.fetchFromGitHub {
        owner = "DisplayLink";
        repo = "evdi";
        rev = "bdc258b25df4d00f222fde0e3c5003bf88ef17b5";
        sha256 = "mt+vEp9FFf7smmE2PzuH/3EYl7h89RBN1zTVvv2qJ/o=";
      };
    });
  });

  # add the displaylink video drivers for xserver
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # enable both external monitors, if more than 2, probably change the number after setprovideroutputsource
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}