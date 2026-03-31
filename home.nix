{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wingeorgune";
  home.homeDirectory = "/home/wingeorgune";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ripgrep
    zoxide
    fd
    fastfetch
    fzf
    tmux
    erlang
    elixir
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    bun
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
  #  /etc/profiles/per-user/wingeorgune/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  #configure lazyvim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
 
  home.file.".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
 
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
        nxs = "home-manager switch -f ~/dotfiles/home.nix";
	ll = "ls -alF";
	ls = "ls -A";
  nv = "nvim";
    };
    initExtra = ''
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi

        if [ -n "$force_color_prompt" ]; then
            if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            color_prompt=yes
            else
            color_prompt=
            fi
        fi

        if [ "$color_prompt" = yes ]; then
            PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]\$ '
        else
            PS1='\u@\h:\w\$ '
        fi
        unset color_prompt force_color_prompt

        if ! shopt -oq posix; then
            if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
            elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
            fi
        fi

        eval "$(zoxide init bash)"
        '';
  };
}
