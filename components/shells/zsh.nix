{ pkgs, ... }:

let
  sharedShellInit = '''';
    # builtins.readFile ./scripts/yazi-shortcut.sh;
in
{
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
    # shellAliases and sessionVariables are set in ./profile.nix.

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initContent = ''
      eval "$(zoxide init zsh)"
      PATH="$PATH:$HOME/thirdparty/appimages/:$HOME/go/bin/:$HOME/.cargo/bin:$HOME/.config/emacs/bin"

      ${sharedShellInit}
      source ${./../../dotfiles/.p10k.zsh}
    '';

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./../../dotfiles;
        file = ".p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };


}
