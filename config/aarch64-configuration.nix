{ config, pkgs, lib, ... }:

{
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = "experimental-features = nix-command flakes";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";
  networking.useDHCP = true; #
  networking.firewall.enable = false;
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  time.timeZone = "Europe/London";

  users.users.jack = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "jack";
    shell = pkgs.nushell;
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";

  programs.zsh.enable = true;

 console.keyMap = "uk";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "gb";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 200 40
      '';
    };

    # ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --mode 1920x1200
    windowManager.i3.enable = true;
  };

  services.displayManager.defaultSession = "none+i3";
  virtualisation.vmware.guest.enable = true;


  system.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;
  environment.shells = with pkgs; [ bashInteractive zsh nushell ];
  environment.systemPackages = with pkgs; [
    cachix
    gnumake
    killall
    xclip
    gtkmm3

    # For hypervisors that support auto-resizing, this script forces it.
    # I've noticed not everyone listens to the udev events so this is a hack.
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ];
}
