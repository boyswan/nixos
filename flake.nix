{
  description = "NixOS System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, home-manager, emacs-overlay, ... }: 
    let 
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        jack = nixpkgs.lib.nixosSystem  {
          inherit system;
          modules = [ 
            ./config/configuration.nix
            home-manager.nixosModules.home-manager {
              nixpkgs.overlays = [
                emacs-overlay.overlay
              ];
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
