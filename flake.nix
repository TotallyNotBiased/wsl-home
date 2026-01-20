{
  description = "Home Manager configuration of unbiased";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim"; 
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."unbiased" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
          ./home.nix 
          nixvim.homeModules.nixvim
	  ./nixvim
        ];
      };
    };
}
