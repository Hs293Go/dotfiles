{ config, pkgs, ... }:

let
  tl-pinned = import (fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/63dacb46bf939521bdc93981b4cbb7ecb58427a0.tar.gz";
    sha256 = "1lr1h35prqkd1mkmzriwlpvxcb34kmhc9dnr48gkm8hh089hifmx";
  }) { };
  tl = tl-pinned.texlive;
  tex = tl.combine {
    inherit (tl)
      scheme-medium latexmk collection-latex collection-latexextra
      collection-latexrecommended collection-bibtexextra collection-luatex
      collection-langcjk collection-publishers collection-fontsrecommended
      collection-fontsextra ut-thesis;
  };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hs293go";
  home.homeDirectory = "/home/hs293go";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Build and dev tools: C++
    ninja
    clang-tools
    gdb
    ccache

    # Build and dev tools: python
    pipx

    # Editors
    neovim

    # Shell QOL 
    fd
    ripgrep
    bat
    fzf
    tldr

    # Fonts
    pkgs.zsh-powerlevel10k
    nerd-fonts.fira-code

    xclip
    direnv

    nodejs_22

    lazygit

    tex

    nmap
    kdePackages.okular
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";

    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi

      source ~/.p10k.zsh

      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      autoload edit-command-line;
      zle -N edit-command-line
      bindkey -M vicmd vv edit-command-line

      if [ $TERM = "xterm-kitty" ] ; then
        alias ssh='kitty +kitten ssh'
      fi

      ros_setup_scripts=(/opt/ros/*/setup.zsh)
      if [ "''${#ros_setup_scripts[@]}" -eq 1 ] ; then
        source "''${ros_setup_scripts[@]:0:1}"
      fi
    '';
    envExtra = ''
      # Bootstrap logic managed by you
      [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    '';
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
      }
      {
        name = "enhancd";
        src = pkgs.fetchFromGitHub {
          owner = "babarot";
          repo = "enhancd";
          rev = "main";
          sha256 = "09wa6s36xlyzbakgqadcjk4g2rzinp2l3irn8ikagl445b11p954";
        };
        file = "init.sh";
      }
      {
        name = "omz-git";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";
          sha256 = "0wwwh5h15gwk68k30wh4bnyy7wbz9v80khgf86gql0gmipzm5038";
        };
        file = "plugins/git/git.plugin.zsh";
      }
      {
        name = "omz-debian";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "master";
          sha256 = "0wwwh5h15gwk68k30wh4bnyy7wbz9v80khgf86gql0gmipzm5038";
        };
        file = "plugins/debian/debian.plugin.zsh";
      }
    ];

  };

  programs.fzf = { enable = true; };

  programs.direnv = {
    enable = true;
    enableZshIntegration =
      true; # or enableBashIntegration / enableFishIntegration
    silent = true;
    config = { load_dotenv = true; };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".p10k.zsh".source = ./dotfiles/p10k.zsh;
    ".prettierrc".source = ./dotfiles/prettierrc;
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    ".vimrc".source = ./dotfiles/vimrc;
    "latexindent.yaml".source = ./dotfiles/latexindent.yaml;
    ".indentconfig.yaml".source = ./dotfiles/indentconfig.yaml;
    ".config/kitty/kitty.conf".source = ./dotfiles/kitty.conf;
    ".ipython/profile_default/ipython_config.py".source =
      ./dotfiles/ipython/profile_default/ipython_config.py;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hs293go/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:/usr/local/cuda/bin:$PATH";
    LD_LIBRARY_PATH = "/usr/local/cuda/lib64:$LD_LIBRARY_PATH";
  };

  home.shellAliases = {
    so = "source";
    sc = "exec $SHELL";
    cls = "clear";
    ll = "ls -l";
    la = "ls -la";
    l = "ls -CF";
    md = "mkdir -p";
    hm = "home-manager";
    hmb = "home-manager build";
    hms = "home-manager switch";
    fdf = "fd -t f";
    fdd = "fd -t d";
    fdr = "fda -uI --follow";
    ffd = "fd -F";
    xc = "xclip -selection clipboard";
    nv = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
