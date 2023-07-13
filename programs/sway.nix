{ config, pkgs, lib, ... }: {

  wayland.windowManager.sway = 
    let 
    mod = "Mod1";
  in {
    enable = true;
    wrapperFeatures.gtk = false;
    config = {
      terminal = "alacritty";
      modifier = "${mod}";

      keybindings = lib.mkOptionDefault {
        "${mod}+c" = "focus child";
        "${mod}+Shift+p" = "exec grim -g \"$(slurp)\" -t png - | wl-copy -t image/png";
        "${mod}+Return" = "exec $term_cwd";
        XF86AudioRaiseVolume = "exec amixer sset Master playback 5%+";
        XF86AudioLowerVolume = "exec amixer sset Master playback 5%-";
        XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        XF86MonBrightnessDown = "exec brightnessctl set 5%-";
        XF86MonBrightnessUp = "exec brightnessctl set 5%+";
      };

      # fonts = [ "Iosevka" ];
      # font_size = 10;

      gaps = {
        inner = 5;
      };

      bars = [
      {
        position = "top";
        colors = {
          statusline = "#ffffff";
          background = "#101010";
        };
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
      set $term_cwd alacritty --working-directory="$(${./dotfiles/sway/swaycwd})"


      client.focused "#383838" "#383838" "#61afef" "#383838" "#61afef75"
      client.focused_inactive "#383838" "#383838" "#c678dd" "#383838" "#61afef75"
      default_border pixel 2
      exec gammastep -O 4000
      '';
  };

# programs.waybar ={
#   enable = true;
# };

                            }
