{ pkgs }:

  pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs.el;
    package = pkgs.emacsPgtk;
    defaultInitFile = true;
    alwaysEnsure = true;
    extraEmacsPackages = epkgs: with epkgs; [
      treesit-grammars.with-all-grammars
    ];
  }


