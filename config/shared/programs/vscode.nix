{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    # Configure Visual Studio Code with some extensions
    vscode = {
      enable = true;
      extensions = with pkgs; [ 
        vscode-extensions.golang.go
        vscode-extensions.vscodevim.vim
        vscode-extensions.github.copilot
        vscode-extensions.eamodio.gitlens
      ];
    };
  };
}