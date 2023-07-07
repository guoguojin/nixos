{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; 
  let
    lua-packages = lua-packages: with lua-packages; [
      luarocks
    ];
    lua-with-packages = lua.withPackages lua-packages;
  in
  [
    lua-with-packages
    lua-language-server
    luaformatter
  ];
}