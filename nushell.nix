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
    settings = {
      edit_mode="vi";
      use_kitty_protocol = true;
      table = {
        mode = "rounded";
      };
      highlight_resolved_externals = true;
    };

  };

  # Automatically integrates Starship with Nushell
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Automatically integrates Zoxide with Nushell
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
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
