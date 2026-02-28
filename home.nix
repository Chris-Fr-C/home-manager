{ config, pkgs, ... }:
{
  # Not using nix
  targets.genericLinux.enable = true;
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "christophe";
  home.homeDirectory = "/home/christophe";

  home.stateVersion = "25.11";
      # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; 
  
  programs.bash.enable = true; # handles the bashrc
  programs.zsh.enable = false; # and the zshrc
  home.packages = with pkgs; [
    # https://search.nixos.org/packages?channel=unstable&query=xonsh
    neovim 
    git
    htop
    # Dev tools
    xonsh # Python + bash, best of both worlds.
    neovim # Best editor.
    zoxide # A better cmd.
    fzf # Fuzzy search.
    yazi # File manager.;
    starship # Make Shell bioutifoul again.
  
    # Code tooling
    # python:
    python313
    uv
  ] ;

  programs.git = {
    enable = true;
    settings.user.name = "Chris-Fr-C";
    settings.user.email = "christophe.fr.corsi@gmail.com";
  };


  # =======================================
  # =           Shell setup               =
  # =======================================
  # Startup hook to add dependencies
  # home.shell = pkgs.xonsh; # Setting default shell
  # If you want to set default shell outside of nixos:
  # chsh -s $(which xonsh)
  # the rc file
  home.file.".config/xonsh/rc.xsh".text = ''
    # Initialize Starship prompt
    eval "$(starship init xonsh)"

    # Load xontribs
    xontrib load term_integration prompt_starship powerline3 jupyter
    xontrib load coreutils nakefile_complete cd kitty onepath
  '';
}
