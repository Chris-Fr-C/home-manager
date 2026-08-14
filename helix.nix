{ pkgs, lib, ... }:
# Here i'll handle plugins in declarative way.

let
  steelCogsDir=".local/share/steel/cogs";
  helixScripts=builtins.readFile ./scripts/helix-plugins.sh;
in
{
  # At the end we run the helix plugins script. If i do it declaratively
  # I have to handle the transitive deps and life is too short for that.
  home.activation = {
    makePotato = lib.hm.dag.entryAfter ["writeBoundary"]
      ''export alias forge=${pkgs.steel}/bin/forge; '' +
      ''${helixScripts}'';
  };

}
