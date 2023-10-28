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

  # Make sure we're running on the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.picom.enable = true;
  services.blueman.enable = true;

  services.postgresql = {
    enable = true;
    ensureDatabases = ["tqq" "vega"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local all      all    trust
    '';
  };
}
