{ config, pkgs, lib, ... }:
let
  shellAliases = {
    cfg-nix="nvim ~/.config/home-manager/home.nix";
    find = "fd";
    cd = "z";
    c = "yazi";
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    vim="nvim";
    lg="lazygit";
    hm="home-manager";
    hme="nvim ~/.config/home-manager/home.nix";
    cz="commitizen";
    zz="zellij";
    # Order is important
    cm="chezmoi --source ${toString ./dotfiles}";
    chezmoi="chezmoi --source ${toString ./dotfiles}";
  };
  sessionVariables={
    # This one is for interactive shells.
    EDITOR = "nvim";
  };
  sharedShellInit=''
      # For management of suspended processes.
      fgf() {
        local job
        job=$(jobs -l | fzf --ansi | awk '{print $1}' | tr -d '[]')
        if [ -n "$job" ]; then
          fg %"$job"
        fi
      }
      # Or with gum 
      fgg() {
        # List jobs with job number + command
        local job
        job=$(jobs -l | awk '{print "[" $1 "] " substr($0, index($0,$3)) }' \
              | gum choose --height 10)

        if [ -n "$job" ]; then
          # Extract job number between brackets
          local job_num=$(echo "$job" | grep -oP '\[\K[0-9]+')
          fg %"$job_num"
        fi
      }

      cfg(){
        cd ~/.config/home-manager
      }

      refresh() {
          local dir=~/.config/home-manager
          # Use fd to list .nix files in the folder, non-recursive
          local file
          file=$(fd --type f --extension nix . "$dir" | xargs -n1 basename | gum choose --height 10)

          if [ -n "$file" ]; then
              echo "Switching to $file..."
              home-manager switch -f "$dir/$file"
          else
              echo "No file selected."
          fi
      }
    term(){
      ttyd -p 9001 -t fontFamily="JetBrainsMono Nerd Font" --writable zsh & disown
    }

      eval "$(pay-respects bash --alias)"
      eval "$(pay-respects zsh --alias)"
      eval "$(zoxide init bash)"
      # Not happy of this. I should refactor it. 
      export PYTHONPATH="$HOME/.local/lib/python3.13/site-packages"
      export JAVA_HOME="$HOME/.nix-profile/bin"

  '';
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
    # neovim <- Deprecated in favour of the app image.
    # fresh

    fuse # For app images.
    coreutils
    # Git related tools
    # Not putting git cause you already need git to clone this repo.
    gh
    lazygit
    commitizen 

    # Cli tools
    htop
    entr # Exec on file changes.
    lazysql # Database viewer.
    k9s # Kubernetes viewer.
    kubectl # Kubernetes operator.
    doggo # Dns viewer.
    nmap # Network scanner.
    visidata # Data wrangler (alias is vd).
    helm # Helm on kubernetes.
    goaccess # For TUI + Web logs.
    mprocs # To vizualise concurrent processes.
    gum # Beautiful prints. 
    eza # Better ls.
    ripgrep  # Grep tool.
    # Press f to pay respect when you miss a command.
    pay-respects
    # Dev tools
    zsh # Classic shell.
    xonsh # Python + bash, best of both worlds.
    zoxide # A better cmd.
    fzf # Fuzzy search.
    yazi # File manager.;
    starship # Make Shell bioutifoul again.
    zellij # Multiplexer. 
    fd # Find tool.
    btop # Process viewer.
    # Code tooling
    chezmoi
    zsh-powerlevel10k
    powerline
    powerline-fonts
    ttyd # Term over browser.
    opencode # AI TUI. 
    gnumake
    go-task
    jdk25_headless # java.

    chafa # Imgs in terminal.
    
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
      # theme = "powerlevel10k/powerlevel10k";
    };
    initContent = ''
      eval "$(zoxide init zsh)"
      PATH="$PATH:$HOME/thirdparty/appimages/:$HOME/go/bin/"

      ${sharedShellInit}
      source ${./dotfiles/.p10k.zsh}
    '';
    plugins=[
        {
          name = "powerlevel10k-config";
          src = ./dotfiles/.p10k.zsh;
          file = ".p10k.zsh";
        }
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];
  };

  # Let chezmoi point to dotfiles here.
  home.file.".local/share/chezmoi" = {
    source=./dotfiles;
    onChange="echo 'Updating dot files...'; ${pkgs.chezmoi}/bin/chezmoi apply";
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

      ${sharedShellInit}
    '';
  };
  
# =======================================
# =          App images                 =
# =======================================  
  home.file."thirdparty/appimages/nvim" = {
    source = builtins.fetchurl {
      url = "https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-linux-x86_64.appimage";
      sha256 = "7876b67462af08abdc884818b398b3e82907d6a4c89edfe7c6b1ff168eb7c4d6";
    };
        executable=true;

  };

  home.file."thirdparty/appimages/fresh" ={
    source= builtins.fetchurl {
      url = "https://github.com/sinelaw/fresh/releases/download/v0.2.21/fresh-editor-0.2.21-x86_64.AppImage";
      sha256 = "9d6907326359095c8566791384f01a9a3fff3e6c79d4576a2a4613ab65395f16";
    };
    executable=true;
  };

  home.file."thirdparty/appimages/helix" ={
    source= builtins.fetchurl {
      url = "https://github.com/helix-editor/helix/releases/download/25.07.1/helix-25.07.1-x86_64.AppImage";
      sha256 = "0d00848ca858e415a4b4a90612702a35aa491421c658c45a06774a265bc4c4f6";
    };
    executable=true;
  };

  home.sessionVariables.PATH = ''
    $HOME/thirdparty/appimages${if builtins.getEnv "PATH" != "" then ":" + builtins.getEnv "PATH" else ""}
  '';
}
