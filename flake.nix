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
            ({pkgs, ... }: { nixpkgs.overlays = [
                emacs-overlay.overlay
                (self: super:
                let
                    emacs29-src = builtins.fetchGit {
                    url = "https://github.com/nix-community/emacs-overlay.git";
                    ref = "emacs-29";
                    rev = "8b4a494d8d4413ae6d566f6478f84e319aeaacdd"; # 29.0.60
                    };
                    # Overlay function
                    emacs-overlay =
                    (import (builtins.fetchGit {
                        url = "https://github.com/nix-community/emacs-overlay.git";
                        ref = "master";
                        rev = "edd4e53eac41bf568856c3728ef0f640411f5e5f"; # 2023-03-25
                    }));
                    #
                    # Extract version pointing to master branch
                    emacsGit = (emacs-overlay self super).emacsGit;
                    #
                    # Override source attribute
                    emacs-29-base = emacsGit.overrideAttrs ( old: {
                    name = "emacs29";
                    version = "29.0-${emacs29-src.rev}";
                    src = emacs29-src;
                    });
                in
                    {
                    emacs-29 = emacs-29-base;
                    }
                )
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
