
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go
    buf
    oapi-codegen
    gopls
    golangci-lint
    golangci-lint-langserver
    gotools # for goimports etc.
    gofumpt
  ];
}