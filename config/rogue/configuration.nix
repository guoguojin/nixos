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
}