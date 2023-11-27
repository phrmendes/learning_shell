{
  description = "My personal nixOS/nix-darwin configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = inputs @ {
    darwin,
    home-manager,
    nixpkgs,
    nixpkgs-stable,
    ...
  }: {
    darwinConfigurations.macos = let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgs;
        };
        modules = [
          ./machines/macos
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs pkgs pkgs-stable;
              };
              backupFileExtension = "bak";
              users.prochame.imports = [
                ./machines/macos/home.nix
              ];
            };
          }
        ];
      };

    nixosConfigurations.nixos = let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgs;
        };
        modules = [
          ./machines/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs pkgs pkgs-stable;
              };
              backupFileExtension = "bak";
              users.phrmendes.imports = [
                ./machines/nixos/home.nix
              ];
            };
          }
        ];
      };
  };
}