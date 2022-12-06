# Configuration file for adding nvidia drivers in offload mode along with display link 
# required to drive the displaylink devices.

{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-GO
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  # make sure the kernel module is loaded in hardware-configuration.nix
  # boot.kernelModules = [ "evdi" ];
  
  environment.systemPackages = [ nvidia-offload ];

  hardware.nvidia.modesetting.enable = true;
  # add the displaylink and nvidia video drivers for xserver
  services.xserver.videoDrivers = [ "displaylink" "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;
    nvidiaBusId = "PCI:46:0:0";
    intelBusId = "PCI:0:2:0";
  };

  # enable both external monitors, if more than 2, probably change the number after setprovideroutputsource
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}
