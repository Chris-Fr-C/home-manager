{pkgs, ... }:

{
  imports = [
    ./base.nix
  ];

  nixpkgs.config = {
    allowUnfree = true; # Needed for vivaldi that is free but not fully opensource.
  };
  home.packages = with pkgs; [
    vivaldi # Browser.
    kitty # Best terminal.
    steam # Gaming.
    heroic # For games on epic gamges GOG etc.
    sunshine # Game streaming.
  ];

}
