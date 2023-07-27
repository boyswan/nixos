{ pkgs }:

  pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs.el;
    defaultInitFile = true;
    alwaysEnsure = true;
  }
