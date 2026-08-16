{ pkgs, ... }:

let
  sessionVariables = {
    # This one is for interactive shells.
    EDITOR = "nvim";
  };
  shellAliases = {
    cfg-nix = "nvim ~/.config/home-manager/home.nix";
    find = "fd";
    cd = "z";
    c = "y"; # instead of yazi so we can leave and set the dir.
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    vim = "nvim";
    lg = "lazygit";
    hm = "home-manager";
    hme = "nvim ~/.config/home-manager/home.nix";
    cz = "commitizen";
    zz = "zellij";
    # Order is important
    em = "emacs -nw";
  };

  sharedShellInit = builtins.readFile ./scripts/functions.sh +
    builtins.readFile ./scripts/initializations.sh +
    builtins.readFile ./scripts/yazi-shortcut.sh;

in

{
  programs.bash = {
    enable = true;
    inherit sessionVariables shellAliases;
    initExtra = ''
      # # include .profile if it exists
      # [[ -f ~/.profile ]] && . ~/.profile
      # export SHELL="${pkgs.zsh}/bin/zsh"
      # [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
      #
      # Opening nu shell
      if [[ $(ps -p $$ -o comm=) != "nu" && -z "$NIX_BUILD_TOP" ]]; then
        exec nu
      fi
      ${sharedShellInit}
    '';
  };

}
