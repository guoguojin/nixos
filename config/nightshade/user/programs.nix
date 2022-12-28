{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ../../user/programs/zsh.nix
    ../../user/programs/vscode.nix
    ../../user/programs/i3status-rust-nightshade.nix
    ../../user/programs/alacritty.nix
    ../../user/programs/tmux.nix
    ../../user/programs/taskwarrior.nix
    ../../user/programs/terminator.nix
    ../../user/programs/autorandr.nix
    ../../user/programs/git.nix
    ../../user/programs/vim.nix
    ../../user/programs/z-lua.nix
  ];
}
