{
  programs.nixvim.globals.mapleader = " ";

  programs.nixvim.keymaps = [
      # General keymaps
      {
	mode = "t";
	key = "<Esc>";
	action = "<C-\\><C-n>";
	options.desc = "Exit terminal mode to Normal mode";
      }
      {
        mode = "n";
	key = "<C-s>";
	action = "<cmd>w<CR>";
      }
      # LSP keymaps
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
	key = "<leader>h";
	action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
	options.desc = "Toggle Inlay Hints";
      }
      # Plugin keymaps
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
	key = "<leader>ff";
	action = "<cmd>Telescope find_files<CR>";
	options.desc = "Telescope Finder";
      }
    ];
  }
