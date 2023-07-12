{ config, pkgs, lib, ... }: {

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = false;
    config = {
      terminal = "alacritty";
      modifier = "Mod1";

      # keybindings = lib.mkOptionDefault {
      #   "Mod1+c" = "focus child";
      # };

      # fonts = [ "Iosevka" ];
      # font_size = 10;

      gaps = {
        bottom = 5;
        horizontal = 5;
        vertical = 5;
        inner = 5;
        left = 5;
        outer = 5;
        right = 5;
        top = 5;
      };

      window = {
        titlebar = false;
      };

      bars = [
        {
          position = "top";
        }
      ];

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "40";
          xkb_options = "caps:escape";
        };
      };

      output = {
        "*" = {
          bg = "#171717 solid_color";
        };
      };

    };

    extraConfig = ''
      exec gammastep -O 4000
    '';
  };

  # programs.waybar ={
  #   enable = true;
  # };

}

