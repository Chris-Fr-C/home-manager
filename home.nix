{ config, pkgs, ... }:
let
  shellAliases = {
    find = "fd";
    z="zoxide";
    # cd = "zoxide";
    c = "yazi";
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    refresh = "home-manager switch";
    vim="nvim";
    lg="lazygit";
    hm="home-manager";
    hme="nvim ~/.config/home-manager/home.nix";
    f="pay-respects";
    cz="commitizen";
  };
  sessionVariables={
    EDITOR = "nvim";
  };
in
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
  
  home.packages = with pkgs; [
    # https://search.nixos.org/packages?channel=unstable&query=xonsh
    # Ide
    neovim 

    # Git related tools
    git
    lazygit
    commitizen 

    htop
    # Press f to pay respect when you miss a command.
    pay-respects
    # Dev tools
    zsh # Classic shell.
    xonsh # Python + bash, best of both worlds.
    neovim # Best editor.
    zoxide # A better cmd.
    fzf # Fuzzy search.
    yazi # File manager.;
    starship # Make Shell bioutifoul again.
    zellij # Multiplexer. 
    # Code tooling
    # python:
    python313
    uv
    chezmoi
    powerline
    
    gnumake
    python313Packages.cmake
    go-task

  ];
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
  '';

  
  # You can set as default with chsh -s $(which xonsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    inherit shellAliases;
    inherit sessionVariables;
    oh-my-zsh = { # "ohMyZsh" without Home Manager
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
    initExtra = ''
    rm ~/.zcompdump*; compinit
    eval "$(zoxide init zsh)"
    '';
  };

  # Let chezmoi point to dotfiles here.
  home.file.".local/share/chezmoi/.chezmoi" = {
    source=./dotfiles;
    onChange="echo 'Updating dot files...'; ${pkgs.chezmoi} apply";
  };

  # Using one of the shells.
  home.shell.enableZshIntegration=true;

  programs.bash = {
    enable=true;     # handles the bashrc
    inherit sessionVariables;
    inherit shellAliases;
    initExtra = ''
      # include .profile if it exists
      [[ -f ~/.profile ]] && . ~/.profile
      # https://unix.stackexchange.com/questions/136423/making-zsh-default-shell-without-root-access
      export SHELL="${pkgs.zsh}/bin/zsh"
      [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
      eval "$(pay-respects bash --alias)"
      eval "$(pay-respects zsh --alias)"
      eval "$(zoxide init bash)"
    '';
  };
  # =======================================
  # =          Development setup          =
  # =======================================
  
}
