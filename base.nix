{ config, pkgs, lib, inputs, ... }:
let
  shellAliases = {
    cfg-nix = "nvim ~/.config/home-manager/home.nix";
    find = "fd";
    cd = "z";
    c = "y"; # instead of yazi so we can leave and set the dir.
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    vim = "nvim";
    lg = "lazygit";
    hm = "home-manager";
    hme = "nvim ~/.config/home-manager/home.nix";
    cz = "commitizen";
    zz = "zellij";
    # Order is important
    em = "emacs -nw";
  };
  sessionVariables = {
    # This one is for interactive shells.
    EDITOR = "nvim";
  };
  sharedShellInit = builtins.readFile ./scripts/functions.sh +
    builtins.readFile ./scripts/initializations.sh +
    builtins.readFile ./scripts/yazi-shortcut.sh;
in
{

  # Target non-NixOS Linux distributions
  targets.genericLinux.enable = true;

  # Home Manager identity settings
  home.username = "christophe";
  home.homeDirectory = "/home/christophe";
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fuse # For app images.
    coreutils

    # Git related tools
    gh
    lazygit
    commitizen

    # CLI tools
    htop
    entr # Exec on file changes.
    lazysql # Database viewer.
    k9s # Kubernetes viewer.
    kubectl # Kubernetes operator.
    doggo # DNS viewer.
    nmap # Network scanner.
    visidata # Data wrangler (alias is vd).
    helm # Helm on kubernetes.
    goaccess # For TUI + Web logs.
    mprocs # To visualize concurrent processes.
    gum # Beautiful prints.
    eza # Better ls.
    ripgrep # Grep tool.
    pay-respects

    # Dev tools
    zsh # Classic shell.
    xonsh # Python + bash, best of both worlds.
    zoxide # A better cd.
    fzf # Fuzzy search.
    yazi # File manager.
    starship # Shell prompt.
    zellij # Multiplexer.
    fd # Find tool.
    btop # Process viewer.

    # Code tooling
    zsh-powerlevel10k
    powerline
    powerline-fonts
    ttyd # Term over browser.
    opencode # AI TUI.
    gnumake
    go-task
    jdk25_headless # java.
    luarocks # For vim deps.

    chafa # Imgs in terminal.
    inotify-tools # File watcher on unix.

    # Functional programming
    babashka # Clojure fast interpreter
    leiningen # Clojure package manager
    clojure

    beam29Packages.elixir
    gleam

    coursier # For scala/java
    # emacs

    lazysql


    wtfutil
  ];

  programs.git = {
    enable = true;
    userName = "Chris-Fr-C";
    userEmail = "christophe.fr.corsi@gmail.com";
  };


  # =======================================
  # =          Shell setup                =
  # =======================================
  home.file.".config/xonsh/rc.xsh".text = ''
    # Initialize Starship prompt
    eval "$(starship init xonsh)"
  '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    inherit shellAliases sessionVariables;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
      PATH="$PATH:$HOME/thirdparty/appimages/:$HOME/go/bin/:$HOME/.cargo/bin:$HOME/.config/emacs/bin"

      ${sharedShellInit}
      source ${./dotfiles/.p10k.zsh}
    '';

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./dotfiles;
        file = ".p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };


  programs.bash = {
    enable = true;
    inherit sessionVariables shellAliases;
    initExtra = ''
      # include .profile if it exists
      [[ -f ~/.profile ]] && . ~/.profile
      export SHELL="${pkgs.zsh}/bin/zsh"
      [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l

      ${sharedShellInit}
    '';
  };


  # =======================================
  # =            App images               =
  # =======================================
  home.file."thirdparty/appimages/nvim" = {
    source = builtins.fetchurl {
      url = "https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-linux-x86_64.appimage";
      sha256 = "7876b67462af08abdc884818b398b3e82907d6a4c89edfe7c6b1ff168eb7c4d6";
    };
    executable = true;
  };

  home.file."thirdparty/appimages/fresh" = {
    source = builtins.fetchurl {
      url = "https://github.com/sinelaw/fresh/releases/download/v0.2.21/fresh-editor-0.2.21-x86_64.AppImage";
      sha256 = "9d6907326359095c8566791384f01a9a3fff3e6c79d4576a2a4613ab65395f16";
    };
    executable = true;
  };

  # App image version for helix
  # home.file."thirdparty/appimages/helix" = {
  #   source = builtins.fetchurl {
  #     url = "https://github.com/helix-editor/helix/releases/download/25.07.1/helix-25.07.1-x86_64.AppImage";
  #     sha256 = "0d00848ca858e415a4b4a90612702a35aa491421c658c45a06774a265bc4c4f6";
  #   };
  #   executable = true;
  # };


  # Helix with built in flag for plugins
    # Steel-enabled Helix compiled with necessary feature flags
  # programs.helix = {
  #   enable = true;
  #   package = inputs.helix-steel.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
  #     cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ [ "--features" "steel,git" ];
  #   });
  #   # settings = {};
  # };


  # Clean way to extend PATH
  home.sessionPath = [
    "$HOME/thirdparty/appimages"
  ];
}
