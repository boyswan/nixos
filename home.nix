{ config, pkgs, ... }: {
  
  home = {
    username = "jack";
    homeDirectory = "/home/jack";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.git.userName = "boyswan";
  programs.git.userEmail = "jackwilliamboyce@gmail.com";

  # # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  home.packages = with pkgs; [ neovim btop ];
}
