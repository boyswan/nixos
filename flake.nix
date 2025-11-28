{
  description = "NixOS System flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager }: 
    {
      nixosConfigurations = {
        # Existing x86 config
        jack = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./config/x86-configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jack = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };

        # VM config for Apple Silicon
        jack_vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ 
            ./config/aarch64-configuration.nix
            ./config/hardware/aarch64-hardware-configuration.nix
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
