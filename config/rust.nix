{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    llvm
    bintools
    zlib
    xorriso
    lld
    lldb
    glibc
    rustup
  ];
}
