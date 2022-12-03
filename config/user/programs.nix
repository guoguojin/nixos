{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ./programs/zsh.nix
    ./programs/vscode.nix
    ./programs/i3status-rust.nix
    ./programs/alacritty.nix
    ./programs/tmux.nix
    ./programs/taskwarrior.nix
    ./programs/terminator.nix
  ];
}
