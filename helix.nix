{ pkgs, ... }:
# Here i'll handle plugins in declarative way.

let
  helixPacks=".config/helix/packs"
in
{


  home.file."${helixPacks}/forest" = {
  source = pkgs.fetchFromGitHub {
    owner = "Ra77a3l3-jar";
    repo = "forest.hx";
    # Replace with the latest commit hash or release tag
    rev = "main";
    # Leave this empty or use lib.fakeHash initially.
    # Nix will fail and tell you the exact hash to paste here.
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  recursive = true;
};
}
