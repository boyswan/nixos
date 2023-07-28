{
  description = "NixOS System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, emacs-overlay }: 
    let 
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        jack = nixpkgs.lib.nixosSystem  {
          inherit system;
          modules = [ 
            ({pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlay ]; })
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
