{ config, pkgs, nixpkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    # We're going to use lazy.nvim and LazyVim to simplify our lives and have sensible configs
    # for neovim to start off with
    plugins = with pkgs.vimPlugins; [
      lazy-nvim         # lazy.nvim plugin manager
      LazyVim           # quick start configuration for vim https://www.lazyvim.org/
    ];
    # this will create our init.lua file in $XDG_CONFIG_HOME/nvim
    extraLuaConfig = ''
      -- bootstrap LazyVim and lazy.nvim
      require "config.lazy"
    '';
  };

  home = {
    # We will manage LazyVim configuration files in the dotfiles folder
    # and simply have NixOS link the files we need for LazyVim to work directly
    file = {
      "${config.xdg.configHome}/nvim/lua" = {
        source = ../../../dotfiles/nvim/lua;
        recursive = true;
      };
      "${config.xdg.configHome}/nvim/stylua.toml" = {
        source = ../../../dotfiles/nvim/stylua.toml;
      };
    };
    # Language server packages for Neovim LSP
    packages = with pkgs; [
      nodePackages.vim-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.pyright
      luaPackages.lua-lsp
    ];
  };
}
