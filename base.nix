{ config, pkgs, lib, ... }:
let
  shellAliases = {
    nixcfg="nvim ~/.config/home-manager/home.nix";
    find = "fd";
    z="zoxide";
    # cd = "zoxide";
    c = "yazi";
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    vim="nvim";
    lg="lazygit";
    hm="home-manager";
    hme="nvim ~/.config/home-manager/home.nix";
    f="pay-respects";
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
    neovim 
    
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
    zsh-powerlevel10k
    powerline
    powerline-fonts
    
    gnumake
    python313Packages.cmake
    go-task
    jre8 # java.


    
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
      eval "$(pay-respects bash --alias)"
      eval "$(pay-respects zsh --alias)"
      eval "$(zoxide init bash)"
      ${sharedShellInit}
    '';
  };
  
  
  # =======================================
  # =          Development setup          =
  # =======================================  
  
}
