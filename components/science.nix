{ pkgs, ... }:

let

in
{
  home.packages = with pkgs; [
    lean4
    elan
  ];

}
