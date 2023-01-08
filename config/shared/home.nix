{ config, pkgs, nixpkgs, ... }:

let
  user = "tanq";
in {
  home.file = {
    "${config.xdg.configHome}/zsh/p10k.zsh" = {
      source = ../../dotfiles/zsh/p10k.zsh;
    };
    "${config.xdg.configHome}/zsh/java_version.zsh" = {
      source = ../../dotfiles/zsh/java_version.zsh;
    };
    "${config.xdg.configHome}/zsh/task.zsh" = {
      source = ../../dotfiles/zsh/task.zsh;
    };
    "${config.xdg.configHome}/i3/scripts/i3exit.sh" = {
      source = ../../dotfiles/i3/scripts/i3exit.sh;
    };
  };
  
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.11";

    sessionVariables = {
      GOPATH = "$HOME/go";
      GOPRIVATE = "gitlab.com/gobl,gitlab.com/gofp,gitlab.com/oakenfield-services";
      PATH = "${config.home.sessionVariables.GOPATH}/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH";
      DOCKER_BUILDKIT = "1";
      XZ_OPT = "-T0";
    };

    packages = with pkgs; [
      google-chrome
      brave
      lastpass-cli
      tomb
      dropbox
      niv
    ];
  };
}
