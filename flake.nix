{
  description = "My personal nixOS/nix-darwin configuration";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autolist-nvim = {
      flake = false;
      url = "github:gaoDean/autolist.nvim";
    };

    cmp-zotcite = {
      flake = false;
      url = "github:jalvesaq/cmp-zotcite";
    };

    img-clip-nvim = {
      flake = false;
      url = "github:HakonHarnes/img-clip.nvim";
    };

    mdeval-nvim = {
      flake = false;
      url = "github:jubnzv/mdeval.nvim";
    };

    zotcite = {
      flake = false;
      url = "github:jalvesaq/zotcite";
    };
  };

  outputs = inputs @ {
    self,
    darwin,
    home-manager,
    nixpkgs,
    nixpkgs-stable,
    ...
  }: {
    darwinConfigurations."SAO-QQ4FN0YXVT" = let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
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
          ./darwin
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
                ./darwin/home
              ];
            };
          }
        ];
      };

    nixosConfigurations.nixos = let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
          ];
        };
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
          ./nixos
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
                ./nixos/home
              ];
            };
          }
        ];
      };
  };
}
