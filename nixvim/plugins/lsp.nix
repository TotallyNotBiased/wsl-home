{
  programs.nixvim.plugins.lsp = {
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
	      enable = false;
	      hideClosureInitialization = false;
	      hideNamedConstructor = false;
	    };
	    chainingHints = { enable = true; };
	    parameterHints = { enable = true; };
	    closureReturnTypeHints = { enable = "never"; };

	  };
	};
      };

      nil_ls.enable = true;
    };
  };

  #programs.nixvim.autoCmd = [
  #  {
  #    event = [ "LspAttach" ];
  #    callback = {
  #      __raw = ''
  #        function(args)
  #          local client = vim.lsp.get_client_by_id(args.data.client_id)
  #          if client.server_capabilities.inlayHintProvider then
  #            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  #          end
  #        end
  #      '';
  #    };
  #  }
  #];
}
