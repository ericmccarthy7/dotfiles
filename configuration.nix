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
  environment.systemPackages = with pkgs; [ 
    adwaita-qt
    alacritty
    avizo
    clang
    corepack_22
    chezmoi
    dunst
    eza
    fuzzel
    fzf
    google-chrome
    kdePackages.polkit-kde-agent-1
    kdePackages.qtwayland
    libsForQt5.qt5.qtwayland
    gnumake
    lua-language-server
    neovim
    nodejs_22
    nwg-look
    openssl
    playerctl
    python312
    python312Packages.pynvim
    python312Packages.black
    readline
    ripgrep
    rose-pine-cursor
    rustup
    spotify
    tealdeer
    uv
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    zellij
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans Mono";
      fontSize = "18";
      loginBackground = false;
    })
  ];

  services.xserver = {
    enable = true;
    displayManager.setupCommands = "xrandr --output DP-1 --primary";
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

