{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    # Configure Visual Studio Code with some extensions
    vscode = {
      enable = true;
      extensions = with pkgs; [ 
        vscode-extensions.arrterian.nix-env-selector
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.mkhl.direnv
        vscode-extensions.rust-lang.rust-analyzer
        vscode-extensions.golang.go
        vscode-extensions.vscodevim.vim
        vscode-extensions.github.copilot
        vscode-extensions.eamodio.gitlens
        vscode-extensions.catppuccin.catppuccin-vsc
        vscode-extensions.catppuccin.catppuccin-vsc-icons
      ];
    };
  };
}
