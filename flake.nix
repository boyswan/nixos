{
  description = "NixOS System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: 
    let 
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        jack = nixpkgs.lib.nixosSystem  {
          inherit system;
          modules = [ 
            ({pkgs, ... }: { nixpkgs.overlays = [
              (import ./overlays/compose.nix)
              ];
            })
            ./config/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jack = {
                imports = [ ./home.nix ];
              };

            }
          ];
        };
      };
    };

}
