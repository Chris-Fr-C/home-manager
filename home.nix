{pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  nixpkgs.config = {
    allowUnfree = true; # Needed for vivaldi that is free but not fully opensource.
  };
  home.packages = with pkgs; [
    (pkgs.vivaldi.override { # Browser.
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    # Steam and Heroic should be installed
    # with pacman as it seems to be a bit
    # complex to setup here.
    ferdium # Com tools.
  ];
}
