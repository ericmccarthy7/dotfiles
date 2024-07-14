{ config, lib, pkgs, ... }:

let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-desktop";
  time.timeZone = "America/Toronto";

  users.users.eric = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.hyprland.enable = true;
  programs.fish.enable = true;
  programs.thunar.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ 
    pkgs.adwaita-qt
    pkgs.alacritty
    pkgs.clang
    pkgs.corepack_22
    pkgs.chezmoi
    pkgs.dunst
    pkgs.eza
    pkgs.fuzzel
    pkgs.fzf
    pkgs.google-chrome
    pkgs.kdePackages.polkit-kde-agent-1
    pkgs.kdePackages.qtwayland
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.gnumake
    pkgs.lua-language-server
    pkgs.neovim
    pkgs.nodejs_22
    pkgs.nwg-look
    pkgs.openssl
    pkgs.playerctl
    pkgs.python312
    pkgs.python312Packages.pynvim
    pkgs.python312Packages.black
    pkgs.readline
    pkgs.ripgrep
    pkgs.rose-pine-cursor
    pkgs.rustup
    pkgs.spotify
    pkgs.tealdeer
    pkgs.uv
    pkgs.wl-clipboard
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.zellij
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans Mono";
      fontSize = "18";
      loginBackground = false;
    })
  ];

  services.xserver = {
    enable = true;
    displayManager.setupCommands = "xrandr --output DP-2 --off";
  };

  services.libinput.mouse.accelProfile = "flat";
  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
  
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];


  
  home-manager.users.eric = {
    home.stateVersion = "24.05";
  
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.gnome-themes-extra;
      };
      cursorTheme = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
	size = 24;
      };
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  system.stateVersion = "24.05";

}

