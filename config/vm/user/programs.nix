{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../shared/programs/zsh.nix
    ../../shared/programs/vscode.nix
    ./programs/i3status-rust.nix
    ../../shared/programs/alacritty.nix
    ../../shared/programs/kitty.nix
    ../../shared/programs/tmux.nix
    ../../shared/programs/taskwarrior.nix
    ../../shared/programs/terminator.nix
    ../../shared/programs/autorandr.nix
    ../../shared/programs/git.nix
    ../../shared/programs/vim.nix
    ../../shared/programs/z-lua.nix
    ../../shared/programs/omp.nix
  ];
}
