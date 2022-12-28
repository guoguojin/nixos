# Configuration file for adding displaylink drivers and the evdi kernel module 
# required to drive the displaylink devices.

{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
}
