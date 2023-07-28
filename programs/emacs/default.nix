{ pkgs }:

  pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs.el;
    defaultInitFile = true;
    alwaysEnsure = true;
    extraEmacsPackages = epkgs: with epkgs; [
      treesit-grammars.with-all-grammars
    ];
  }


