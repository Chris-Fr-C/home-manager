{ ... }:

let
  sessionVariables = {
    EDITOR = "nvim";
    EMACS = "neomacs";
    DOOMDIR = "~/.config/doom";
    COLORTERM = "truecolor";
  };

  shellAliases = {
    cfg-nix = "nvim ~/.config/home-manager/home.nix";
    cfg = "cd ~/.config/home-manager";
    cfgvim = "cd ~/.config/home-manager/dotfiles/config/nvim/lua/custom";
    find = "fd";
    cd = "z";
    # `y` wraps yazi so the shell keeps the dir yazi exits in.
    c = "y";
    ls = "eza --icons=always";
    lsl = "ls -l";
    lsls = "lsl --total-size";
    bench = "hyperfine";
    vim = "nvim";
    lg = "lazygit";
    lsql = "lazysql";
    hm = "home-manager";
    hme = "nvim ~/.config/home-manager/home.nix";
    cz = "commitizen";
    zz = "zellij";
    em = "neomacs -nw";
    emacs = "neomacs";
    cat = "bat";
    doom = "~/.config/emacs/bin/doom";
  };
in
{
  # Single source of truth for shell env vars and aliases.
  # Shell-specific modules (bash/zsh/nushell) must not duplicate these;
  # they only configure interactive behavior (init, plugins, settings).
  home.sessionVariables = sessionVariables;
  home.shellAliases = shellAliases;

  programs.bash.sessionVariables = sessionVariables;
  programs.bash.shellAliases = shellAliases;

  programs.zsh.sessionVariables = sessionVariables;
  programs.zsh.shellAliases = shellAliases;

  # Nushell uses different option names and does not pick up home.* implicitly.
  programs.nushell.environmentVariables = sessionVariables;
  programs.nushell.shellAliases = shellAliases;
}
