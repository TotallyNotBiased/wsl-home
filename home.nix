{ config, pkgs, ... }:

{
  home.username = "unbiased";
  home.homeDirectory = "/home/unbiased";

  home.stateVersion = "25.11";

  home.packages = (with pkgs; [
    fastfetch
    nerd-fonts.jetbrains-mono
    gh
    git-filter-repo
  ]);

  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "highfunctioningpsychopath@gmail.com";
        name = "TotallyNotBiased";
        init.defaultBranch = "main";
      };
    };
  };
  
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      format = "$username$directory$git_branch$git_status$nix_shell$character";

      username = {
        show_always = true;
        style_user = "bg:#cba6f7 fg:#1e1e2e";
        style_root = "bg:#f38ba8 fg:#1e1e2e";
        format = "[ $user ]($style)[](bg:#313244 fg:#cba6f7)";
      };

      directory = {
        style = "bg:#313244 fg:#cdd6f4";
        format = "[ $path ]($style)[](fg:#313244) ";
      };

      git_branch = {
        symbol = "";
        style = "bg:#313244";
        format = "[[ $symbol $branch ](fg:#cba6f7 bg:#313244)]($style)";
      };

      git_status = {
        style = "bg:#313244";
        format = "[[($all_status$ahead_behind )](fg:#cba6f7 bg:#313244)]($style)";
      };

      nix_shell = {
        disabled = false;
        symbol = "";
        style = "bg:#89b4fa fg:#1e1e2e";
        format = "[ $symbol $name ]($style) ";
      };

      character = {
        success_symbol = " [➜](bold green)";
        error_symbol = " [➜](bold red)";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };


  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      bind-key j switch-client -n
      bind-key k switch-client -p

      # Visual selection and yank like vim in copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };


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

  home.sessionVariables = {
  };

  home.shellAliases = {
    conf = "cd ~/.config/home-manager";
    rebuild = "home-manager switch --flake ~/.config/home-manager";
    rebuild-all = "git -C ~/.config/home-manager add . && home-manager switch --flake ~/.config/home-manager";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
