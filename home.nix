{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    ferdium
    forge-mtg # Solo magic da gathering for da win
    rsync # file copy and backup.
    grsync # with ui
    rclone
    rclone-browser

  ];
}
