# Common HomeManager configuration for all installations
# Update this if you want to make sure all builds have
# a common set of user space packages.
{ config, pkgs, nixpkgs, ... }:

let
  user = "tanq";
in {
  home = {
    stateVersion = "23.05";

    # files and folders we want to map in the filesystem
    # instead of using generated nix files.
    file = {
      # Powerlevel10K configuration script
      "${config.xdg.configHome}/zsh/p10k.zsh" = {
        source = ../../dotfiles/zsh/p10k.zsh;
      };
      # P10K plugin script to get the currently installed Java version
      "${config.xdg.configHome}/zsh/java_version.zsh" = {
        source = ../../dotfiles/zsh/java_version.zsh;
      };
      # P10K plugin script to display taskwarrior status
      "${config.xdg.configHome}/zsh/task.zsh" = {
        source = ../../dotfiles/zsh/task.zsh;
      };
      # Exit script for i3
      "${config.xdg.configHome}/i3/scripts/i3exit.sh" = {
        source = ../../dotfiles/i3/scripts/i3exit.sh;
      };
    };
    username = "${user}";
    homeDirectory = "/home/${user}";

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
      dropbox-cli
      niv
      obsidian
    ];
  };
}
