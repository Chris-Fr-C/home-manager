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

    # fonts:
    nerd-fonts.daddy-time-mono # Lol dat name
    nerd-fonts.monaspace # or monaspace
    nerd-fonts.victor-mono

    symbola # font
    syncthing # for sync of my notes with my phone.
    joplin-cli

  ];



  home.file."thirdparty/appimages/neomacs" = {
    source = builtins.fetchurl {
      url = "https://github.com/eval-exec/neomacs/releases/download/v0.0.18/neomacs-0.0.18-x86_64-unknown-linux-gnu.AppImage";
      sha256 = "sha256:aa394266b0932685c451d7149403ca6b1c5403db9595dd2f3d203c26eb26ebd2";
    };
    executable = true;
  };

  # Personal data management (like obsidian).
  home.file."thirdparty/appimages/joplin" = {
    source = builtins.fetchurl {
      url = "https://github.com/laurent22/joplin/releases/download/v3.7.18/Joplin-3.7.18.AppImage";
      sha256 = "sha256:c7ed7eeb6985621b75f0d09088cd01efc9af7aa2cfa17649ed4a83a75b29aca5";
    };
    executable = true;
  };

}
