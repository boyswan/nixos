{ config, pkgs, lib, ... }: {

  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = "#98c379";
      color_degraded = "#d19a66";
      color_bad = "#e06c75";
      interval = 1;
    };
  };

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
          "${mod}+Return" = "exec alacritty --working-directory=\"$(${./swaycwd})\"";
          XF86AudioRaiseVolume = "exec amixer sset Master playback 5%+";
          XF86AudioLowerVolume = "exec amixer sset Master playback 5%-";
          XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          XF86MonBrightnessDown = "exec brightnessctl set 5%-";
          XF86MonBrightnessUp = "exec brightnessctl set 5%+";
        };

        fonts = {
          size = 10.0;
        };

        gaps.inner = 5;
        bars = [{
            fonts = {
              names = [ "monospace" ];
              size = 10.0;
            };
            # statusCommand = "i3status-rs $HOME/.config/i3status-rust/config-top.toml";
            statusCommand = "i3status";
            position = "top";
            # extraConfig = "height 16";
          }];
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
        client.focused "#383838" "#383838" "#61afef" "#383838" "#61afef75"
        client.focused_inactive "#383838" "#383838" "#c678dd" "#383838" "#61afef75"
        default_border pixel 2
        exec gammastep -O 3000
        '';
    };

}

