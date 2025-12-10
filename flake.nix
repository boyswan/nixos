{
  description = "NixOS System flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # opencode-flake.url = "github:aodhanhayter/opencode-flake";
    opencode-flake.url = "github:sst/opencode"; 
    claude-code.url = "github:sadjow/claude-code-nix";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: let 
    overlays = [
      (final: prev: {
        # gh CLI on stable has bugs.
        gh = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.gh;
        # claude-code = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.claude-code;
        claude-code = inputs.claude-code.overlays.default;
        # opencode = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.opencode;
      })
    ];
    in {
      nixosConfigurations = {
        # Existing x86 config
        jack = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          overlays = overlays;
          specialArgs = { inherit inputs; }; 
          modules = [ 
            ./config/x86-configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jack = {
                imports = [ ./programs/home-manager.nix ];
              };
            }
          ];
        };

        # VM config for Apple Silicon
        jack_vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; }; 
          modules = [
            ./config/aarch64-configuration.nix
            ./config/hardware/aarch64-hardware-configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jack = {
                imports = [ ./programs/home-manager.nix ];
              };
            }
          ];
        };
      };
    };
}
