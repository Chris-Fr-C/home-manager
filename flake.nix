{
  description = "Home Manager Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  # Use the active Steel fork branch to have the plugin system.
   helix-steel = {
    url = "github:mattwparas/helix/steel-event-system";
    inputs.nixpkgs.follows = "nixpkgs";
  };


  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
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
        # Build with: home-manager switch --flake .#home
        "home" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./base.nix
            ./home.nix
            ./dotfiles.nix
            ./helix.nix
          ];
        };

        # Profile 2: AXPO WSL Machine
        # Build with: home-manager switch --flake .#axpo-wsl
        "axpo-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./base.nix
            ./axpo-wsl.nix
            ./dotfiles.nix
            ./helix.nix
          ];
        };

      };
    };
}
