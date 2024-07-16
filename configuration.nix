{ config, lib, pkgs, ... }:

let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
unstable = import 
  (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable")
  { config = config.nixpkgs.config; };
in
{
  imports = [
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
  programs.steam.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };


  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ 
    adwaita-qt
    alacritty
    audacity
    avizo
    bitwig-studio
    clang
    corepack_22
    coreutils
    chezmoi
    davinci-resolve-studio
    discord
    dunst
    eww
    eza
    ffmpeg
    fuzzel
    gimp
    google-chrome
    htop
    hyprlock
    inkscape
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    kdePackages.polkit-kde-agent-1
    kdePackages.qtwayland
    killall
    krita
    libinput
    libsForQt5.qt5.qtwayland
    gnumake
    lua-language-server
    unstable.neovim
    nodejs_22
    parted
    libnotify
    mpv
    nwg-look
    obs-studio
    openssl
    playerctl
    python312
    python312Packages.pynvim
    python312Packages.black
    readline
    ripgrep
    rose-pine-cursor
    ruff
    rustup
    spotify
    tealdeer
    uv
    vlc
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    yabridge
    zellij
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans Mono";
      fontSize = "18";
      loginBackground = false;
    })
  ];

  services.jellyfin.enable = true;
  services.xserver = {
    enable = true;
    config = ''
      Section "InputClass"
        Identifier "libinput pointer catchall"
        MatchIsPointer "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "AccelProfile" "flat"
        Option "Accel Profile Enabled" "1 0 0"
      EndSection
    '';
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      additionalOptions = ''
        Option "AccelProfile" "flat"
        Option "Accel Profile Enabled" "1 0 0"
      '';
    };
    touchpad = {
      accelProfile = "flat";
      accelSpeed = "0";
    };
  };
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

