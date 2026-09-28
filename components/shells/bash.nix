{ pkgs, ... }:

let
  sharedShellInit = '''';
    # builtins.readFile ./scripts/functions.sh +

in

{
  programs.bash = {
    enable = true;
    # sessionVariables and shellAliases are set in ./profile.nix.
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
