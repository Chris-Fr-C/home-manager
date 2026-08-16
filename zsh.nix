{ pkgs, ... }:

let
  sessionVariables = {
    # This one is for interactive shells.
    EDITOR = "nvim";
  };
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

  sharedShellInit = builtins.readFile ./scripts/functions.sh +
    builtins.readFile ./scripts/initializations.sh +
    builtins.readFile ./scripts/yazi-shortcut.sh;
in
{
  zsh # Classic shell.
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k

  ];

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

``

}
