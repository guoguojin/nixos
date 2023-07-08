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
      ../go.nix
      ../rust.nix
      ../python.nix
      ../lua.nix
      ../jetbrains.nix
      ../kubernetes.nix
      ../steam.nix
    ];

  networking.hostName = "hawkeye"; # Define your hostname.

  services.picom.enable = true;
  services.blueman.enable = true;
}
