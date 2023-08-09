# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  # Only pull in what we need for the specific machine
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
      ../i3.nix
      ../evdi.nix
    ];

  # And define the hostname
  networking.hostName = "rogue"; # Define your hostname.

  # Make sure we're running on the latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

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

  services.picom.enable = true;
}