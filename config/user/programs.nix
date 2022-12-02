{ config, pkgs, nixpkgs, ... }:

{
    imports = [
        ./programs/zsh.nix
        ./programs/vscode.nix
    ];
}
