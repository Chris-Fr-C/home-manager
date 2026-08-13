{
  description = "Home Manager Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nova-repo = {
      url = "github:Yazelix/nova";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nova-repo, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations = {
        # Profile 1: Desktop Machine
        # Build with: home-manager switch --flake .#christophe
        "christophe" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./base.nix
            ./home.nix
          ];
        };

        # Profile 2: AXPO WSL Machine
        # Build with: home-manager switch --flake .#axpo-wsl
        "axpo-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home.nix
            ./axpo-wsl.nix
          ];
        };
      };
    };
}
