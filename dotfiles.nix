{ config, pkgs, lib, inputs, ... }:
let
in
{
  home.file."p10k.zsh" = {
    source=./dotfiles/.p10k.zsh
  };
  xdg.configFile = {
    # Recursively symlinks all files inside ./dotfiles/config into ~/.config/
    # ".".source = ./dotfiles/config;

    # Or targeting specific folders individually:
    "nvim".source = ./dotfiles/config/nvim;
    "doom".source = ./dotfiles/config/doom;;
    "helix".source = ./dotfiles/config/helix;;
    "zellij".source = ./dotfiles/config/zellij;;
    "starship.toml".source = ./dotfiles/config/starship.toml;;
    source=./dotfiles/config;
    recursive=true;
  }
}
