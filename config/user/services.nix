{ config, pkgs, nixpkgs, ... }:

{
  services = {
    udiskie = {
      automount = true;
      notify = true;
    };

    gpg-agent = {
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}