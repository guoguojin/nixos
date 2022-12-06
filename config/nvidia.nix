# Configuration file for adding displaylink drivers and the evdi kernel module 
# required to drive the displaylink devices.

{ config, lib, pkgs, ... }:

{
  # make sure the kernel module is loaded in hardware-configuration.nix
  # boot.kernelModules = [ "evdi" ];

  # add the displaylink video drivers for xserver
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:46:0:0";
    intelBusId = "PCI:0:2:0";
  };

  # enable both external monitors, if more than 2, probably change the number after setprovideroutputsource
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}
