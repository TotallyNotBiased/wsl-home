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

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin.enable = true;
    web-devicons.enable = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      treesitter.enable = true;
      lsp-lines.enable = true;

      lsp = {
        enable = true;
	servers = {
	  rust_analyzer = {
	    enable = true;
	    installCargo = true;
	    installRustc = true;

	    settings = {
	      inlayHints = {
		bindingModeHints = { enable = true; };
		typeHints = {
		  enable = true;
		  hideClosureInitialization = false;
		  hideNamedConstructor = false;
		};
		chainingHints = { enable = true; };
		parameterHints = { enable = true; };
		closureReturnTypeHints = { enable = "always"; };
	      };
	    };
	  };

	  nil_ls.enable = true;
	};
      };

      cmp = {
        enable = true;
	autoEnableSources = true;
	settings = {
	  sources = [
	    { name = "nvim_lsp"; }
	    { name = "path"; }
	    { name = "buffer"; }
	  ];
	  mapping = {
	    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
	  };
	};
      };

      neo-tree = {
	enable = true;
	closeIfLastWindow = true; # Close vim if only the tree is left
	window = {
	  width = 30; # Set the width of the sidebar
	  autoExpandWidth = true;
	};
      };

      toggleterm = {
	enable = true;
	settings = {
	  direction = "float"; # 'vertical', 'horizontal', 'tab', or 'float'
	  float_opts = {
	    border = "curved";
	  };
	};
      };
    };

    keymaps = [
      {
	key = "gd";
	action = "<cmd>lua vim.lsp.buf.definition()<CR>";
	options.desc = "Go to Definition";
      }
      {
	key = "K";
	action = "<cmd>lua vim.lsp.buf.hover()<CR>";
	options.desc = "Hover Documentation";
      }
      {
	key = "<leader>ca";
	action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
	options.desc = "Code Action";
      }
      {
	key = "<leader>rn";
	action = "<cmd>lua vim.lsp.buf.rename()<CR>";
	options.desc = "Rename Symbol";
      }
      {
	key = "<leader>e";
	action = "<cmd>Neotree toggle<CR>";
	options.desc = "Toggle Explorer";
      }
      {
	key = "<leader>t";
	action = "<cmd>ToggleTerm<CR>";
	options.desc = "Toggle Terminal";
      }
      {
	key = "<leader>h";
	action = ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
	options.desc = "Toggle Inlay Hints";
      }
    ];

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    autoCmd = [
      {
	event = [ "LspAttach" ];
	callback = {
	  __raw = ''
	    function(args)
	      local client = vim.lsp.get_client_by_id(args.data.client_id)
	      if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
	      end
	    end
	  '';
	};
      }
    ];
  }; 

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
