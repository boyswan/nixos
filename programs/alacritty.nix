{ config, pkgs, lib, ... }:  {

  programs.alacritty = {
    enable = true;
    settings = {

      env = {
        # "TERM" = "xterm-256color";
        "TERM" = "alacritty";
      };
      
      font = {
        size = 12;
        family = "Iosevka";
      };

      window.padding = {
        x = 10;
        y = 10;
      };

      colors = {
        primary = {
          foreground = "0xE1E1E1";
          background = "0x232326";
        };

        normal =  {
          black =    "0x1e2127";
          red =      "0xe06c75";
          green =    "0x98c379";
          yellow =   "0xd19a66";
          blue =     "0x57a5e5";
          magenta =  "0xc678dd";
          cyan =     "0x56b6c2";
          white =    "0x828791";
        };
      };
    };
  };

                             }
