{ config, pkgs, lib, inputs, ... }:
let
  dotfilesDir = "${config.home.homeDirectory}/.config/home-manager/dotfiles/config";
in
{
  # xdg.configFile would ve read only so nvim etc would fail.

  home.file = {
    # Recursively symlinks all files inside ./dotfiles/config into ~/.config/
    # ".".source = ./dotfiles/config;
    # p10k is setup in the plugin section of base.nix


    # Or targeting specific folders individually:
    ".config/nvim" ={
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
      force = true;
      # recursive = true; 
      # executable=true;
    };

    ".config/doom" = {
      source = ./dotfiles/config/doom;
      force = true;
      # recursive = true;
      # executable=true;
    };

    ".config/helix" = {
      source = ./dotfiles/config/helix;
      force=true;
      # recursive=true;
      # executable=true;
    };

    ".config/zellij" = {
      source = ./dotfiles/config/zellij;
      force=true;
      # recursive=true;
      # executable=true;
    };

    ".config/starship.toml" = {
        source = ./dotfiles/config/starship.toml;
        # force=true;
        # executable=true;
    };
  };
}
