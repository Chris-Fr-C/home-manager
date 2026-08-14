{ config, pkgs, lib, inputs, ... }:
let
in
{
  home.file.".p10k.zsh" = {
    source=./dotfiles/.p10k.zsh;
  };
  xdg.configFile = {
    # Recursively symlinks all files inside ./dotfiles/config into ~/.config/
    # ".".source = ./dotfiles/config;

    # Or targeting specific folders individually:
    "nvim" ={
      source = ./dotfiles/config/nvim;
      force = true;
    recursive = true;
    };

    "doom" = {
      source = ./dotfiles/config/doom;
      force = true;
      recursive = true;
    };

    "helix" = {
      source = ./dotfiles/config/helix;
      force=true;
      recursive=true;
    };

    "zellij" = {
      source = ./dotfiles/config/zellij;
      force=true;
      recursive=true;
    };

    "starship.toml" = {
        source = ./dotfiles/config/starship.toml;
        force=true;
    };
  };
}
