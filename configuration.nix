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
    shell = pkgs.bashInteractive;
  };

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.dconf.enable = true;
  programs.fish.enable = true;
  programs.thunar.enable = true;
  programs.steam.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ 
    adwaita-qt
    alacritty
    audacity
    avizo
    bash
    bitwig-studio
    btop
    clang
    corepack_22
    coreutils
    chezmoi
    curl
    davinci-resolve-studio
    discord
    dunst
    eww
    eza
    ffmpeg
    fuzzel
    gimp
    google-chrome
    guvcview
    htop
    inkscape
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    just
    jq
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
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
    touchpad = {
      accelProfile = "flat";
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
    nerdfonts
  ];


  
  home-manager.backupFileExtension = "hmbak";

  home-manager.users.eric = {
    home.stateVersion = "24.05";

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
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
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
	monitor = [
          "DP-1,3840x2160@60.00Hz,1920x0,2"
          "DP-2,1920x1080@239.76Hz,0x0,1"
	];
	xwayland = {
	  force_zero_scaling = true;
	};
        "$terminal" = "alacritty";
        "$fileManager" = "thunar";
        "$menu" = "fuzzel";
	"exec-once" = [
          "[workspace 1] google-chrome-stable"
          "[workspace 3 silent] $terminal"
          "[workspace 2 silent] spotify"
          "hyprctl setcursor BreezeX-RosePine-Linux 24"
          "avizo-service"
	];
	"env" = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
	];
	"$mod" = "SUPER";
	"$mainMod" = "SUPER";
	general = {
	  gaps_in = 0;
	  gaps_out = 0;
	  border_size = 0;
	  allow_tearing = false;
	  layout = "dwindle";
	};
	decoration = {
	  rounding = 0;
	  active_opacity = 1.0;
	  inactive_opacity = 1.0;
	  drop_shadow = false;
	  blur.enabled = false;
	};
	animations = {
	  enabled = true;
	  bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
	  ];
	};

	dwindle = {
	  pseudotile = true;
	  preserve_split = true;
	};

	master = {
	  new_status = "master";
	};

	misc = {
	  force_default_wallpaper = 1;
	  disable_hyprland_logo = true;
	};

	bind = [
          "$mainMod, Q, killactive,"
          "CONTROL $mainMod, Q, exec, hyprlock"
          "$mainMod, T, exec, eww open clock1 --toggle && eww open clock2 --toggle"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, Space, exec, $menu"
          "$mainMod, P, pseudo,"
          "ALT SHIFT, 1, workspace, 1"
          "ALT SHIFT, 2, workspace, 2"
          "ALT SHIFT, 3, workspace, 3"
          "ALT SHIFT, 4, workspace, 4"
          "ALT SHIFT, 5, workspace, 5"
          "ALT SHIFT, 6, workspace, 6"
          "CONTROLALT SHIFT, 1, movetoworkspace, 1"
          "CONTROLALT SHIFT, 2, movetoworkspace, 2"
          "CONTROLALT SHIFT, 3, movetoworkspace, 3"
          "CONTROLALT SHIFT, 4, movetoworkspace, 4"
          "CONTROLALT SHIFT, 5, movetoworkspace, 5"
          "CONTROLALT SHIFT, 6, movetoworkspace, 6"
          "ALT SHIFT, E, focusmonitor, DP-1"
          "ALT SHIFT, W, focusmonitor, DP-2"
          "CONTROLALT SHIFT, e, movecurrentworkspacetomonitor, DP-1"
          "CONTROLALT SHIFT, w, movecurrentworkspacetomonitor, DP-2"
          "CONTROLALT SHIFT, L, movetoworkspace, e+1"
          "ALT SHIFT, F, centerwindow"
          "CONTROLALT SHIFT, F, togglefloating"
          "ALT SHIFT, N, workspace, e+1"
          "ALT SHIFT, J, cyclenext, prev"
          "CONTROLALT SHIFT, J, swapnext, prev"
          "ALT SHIFT, K, cyclenext"
          "CONTROLALT SHIFT, K, swapnext"
          "ALT SHIFT, Space, togglesplit,"
        ];
        bindle = [
          ", XF86AudioRaiseVolume, exec, volumectl -u up"
          ", XF86AudioLowerVolume, exec, volumectl -u down"
        ];
        bindl =[
          ", XF86AudioMute, exec, exec, volumectl toggle-mute"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

	];
	device = {
	  name = "logitech-usb-receiver";
	  accel_profile = "flat";
	};
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          accel_profile = "flat";
          force_no_accel = 1;
        };
      };
      extraConfig = ''
        input {
	    accel_profile = "flat"
	    force_no_accel = 1	
	}

        device {
            name = logitech-usb-receiver
            accel_profile = flat
        }
        
        device {
            name = logitech-usb-receiver-keyboard-1
            accel_profile = flat
        }
        
        device {
            name = logitech-pro-x-wireless-1
            accel_profile = flat
        }
        
        device {
            name = logitech-pro-x-wireless-2
            accel_profile = flat
        }
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  systemd.timers."weather-update" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30m";
        OnUnitActiveSec = "30m";
        Unit = "weather-update.service";
      };
  };
  
  systemd.services."weather-update" = {
    script = ''
      set -eu
      date '+%Y-%m-%d %H:%M:%S'
      bash /home/eric/.config/eww/scripts/weather --getdata
    '';
    path = [ 
      pkgs.bash
      pkgs.coreutils
      pkgs.curl
      pkgs.jq
    ];
    serviceConfig = {
      Type = "oneshot";
      User = "eric";
    };
  };

  system.stateVersion = "24.05";
}

