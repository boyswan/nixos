{ config, pkgs, lib, ... }: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      height = 24;
      # layer = "top";
      position = "top";
      tray = { spacing = 6; };
      modules-center = [ "sway/window" ];
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "clock"
        "tray"
      ];
      battery = {
        format = "BAT {capacity}%";
        format-charging = "BAT +{capacity}%";
        format-plugged = "BAT +{capacity}%";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format = "{:%Y-%m-%d  %H:%M}";
      };
      cpu = {
        format = "CPU {usage}%";
      };
      memory = { format = "MEM {}%"; };
      network = {
        interval = 1;
        format = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "OFFLINE";
        # format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        # format-linked = "{ifname} (No IP) ";
        format-wifi = "WIFI {essid} {ipaddr} {signalStrength}%";
      };
      pulseaudio = {
        format = "VOL {volume}%";
        format-muted = "MUTE";
        on-click = "pavucontrol";
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "TEMP {temperatureC}°C ";
      };
    }];

    style = ''
        @define-color black #101012;
        @define-color white #ffffff;
        @define-color red #de5d68;
        @define-color focused #2c2d31;
        @define-color blue #383838;

        * {
          font-size: 14px;
          font-family: monospace;
        }

        window#waybar {
          background: @black;
          color: @white;
        }

        widget > * {
          margin-right: 14px;
          color: @white;
        }

         #workspaces button.focused {
          color: @white;
          border: @blue;
          background-color: @focused;
         }
        
        #workspaces button.urgent {
          color: @red;
        }
    '';
  };


                            }

