{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    home-manager.enable = true;

    # Configure Zsh
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      initExtra = ''
      # Source powerlevel10k
      [[ -f ${config.xdg.configHome}/zsh/.p10k.zsh ]] && source ${config.xdg.configHome}/zsh/.p10k.zsh
      [[ -f ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme ]] && source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';

      shellAliases = {
        ll = "ls -l";
        psgrep = "ps aux | grep";
      };

      history = {
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        size = 10000;
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
    };

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