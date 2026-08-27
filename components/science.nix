{ pkgs, ... }:

let

in
{
  home.packages = with pkgs; [
    elan # Version manager for lean 4.
  ];

}
