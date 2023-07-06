{ config, pkgs, nixpkgs, ... }:

{
  imports = [
    ./programs/zsh.nix
    ./programs/vscode.nix
    ./programs/alacritty.nix
    ./programs/tmux.nix
    ./programs/taskwarrior.nix
    ./programs/terminator.nix
    ./programs/autorandr.nix
    ./programs/git.nix
    ./programs/vim.nix
    ./programs/nushell.nix
    ./programs/omp.nix
    ./programs/zoxide.nix
    ./programs/kitty.nix
    ./programs/direnv.nix
  ];
}
