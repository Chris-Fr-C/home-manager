{ pkgs, ... }:

let
  sessionVariables = {
    # This one is for interactive shells.
    EDITOR = "nvim";
  };

in
{
  home.packages = with pkgs; [
    nushell
  ];

  programs.nushell = {
    enable = true;
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -t 1 ] && [ -x "$(command -v nu)" ]; then
        exec nu
      fi
    '';
  };


}
