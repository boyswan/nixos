{ pkgs }:

  pkgs.emacsWithPackagesFromUsePackage {
    config = ./init.el;
    package = pkgs.emacs-pgtk;
    defaultInitFile = true;
    alwaysEnsure = true;
    extraEmacsPackages = epkgs: with epkgs; [
      treesit-grammars.with-all-grammars
    ];
  }


