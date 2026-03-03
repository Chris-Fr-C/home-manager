{ pkgs, ... }:

{
  imports =[./base.nix];

  # Azure dependencies
  home.packages = with pkgs; [
    sqlcmd
    azure-cli
    powershell
    wslu
    python313Packages.keyring
    azure-artifacts-credprovider
  ];


}
