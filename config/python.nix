{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; 
  let
    python-packages = python-packages: with python-packages; [
      pip
      requests
      setuptools
      pynvim
      autopep8
      yapf
      pytest
      flake8
      pyenv
    ];
    python-with-packages = python311Full.withPackages python-packages;
  in
  [
    python-with-packages
    poetry
    black
  ];
}