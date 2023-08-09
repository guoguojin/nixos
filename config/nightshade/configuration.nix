# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
      ../i3.nix
      ../nvidia.nix
    ];

  networking.hostName = "nightshade"; # Define your hostname.

  # Make sure we're running on the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.picom = {
    enable = true;
    backend = "xrender";
    settings = {
      unredir-if-possible = false;
    };
    vSync = true;
  };

}
