{
  description = "A NixOS installation flake for my computer systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    user = "tanq";
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      rogue = lib.nixosSystem {
        inherit system;
        modules = [
          ./config/rogue/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./config/rogue/home.nix
              ];
            };
          }
        ];
      };
      hawkeye = lib.nixosSystem {
        inherit system;
        modules = [
          ./config/hawkeye/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./config/hawkeye/home.nix
              ];
            };
          }
        ];
      };
      songbird = lib.nixosSystem {
        inherit system;
        modules = [
          ./config/songbird/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./config/songbird/home.nix
              ];
            };
          }
        ];
      };
      nightshade = lib.nixosSystem {
        inherit system;
        modules = [
          ./config/nightshade/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./config/nightshade/home.nix
              ];
            };
          }
        ];
      };
    };
  };
}
