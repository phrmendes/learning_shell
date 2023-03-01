{ config, pkgs, ... }:
let
  user = "phrmendes";
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
  unstableTarball = builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  themes = pkgs.callPackage ./sddm.nix {};
in {
  imports = [
      (import "${home-manager}/nixos")
      ./hardware-configuration.nix
      ./home.nix
    ];
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      timeout = 5;
    };
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };
  time.timeZone = "America/Sao_Paulo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_us.UTF-8";
      LC_MONETARY = "pt_BR.UTF8";
      LC_MEASUREMENT = "pt_BR.UTF8";
      LC_TIME = "pt_BR.UTF8";
      LC_NUMERIC = "pt_BR.UTF8";
    };
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "SourceCodePro" ];
      };
    };
  };
  services = {
    clipmenu.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
      autorun = true;
      layout = "us,br";
      videoDrivers = [ "nvidia" ];
      desktopManager.plasma5 = {
        enable = true;
        excludePackages = with pkgs.libsForQt5; [
          elisa
          oxygen
          khelpcenter
          konsole
          print-manager
        ];
      };
      displayManager.sddm = {
        enable = true;
        autoNumlock = true;
        theme = "nordic-custom-theme";
        settings.Theme.CursorTheme = "breeze_cursors";
      };
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          naturalScrolling = true;
        };
      };
    };
    journald.extraConfig = "SystemMaxUse=1G";
  };
  security.pam.services = {
    sddm.enableKwallet = true;
    kwallet = {
      name = "kwallet";
      enableKwallet = true;
    };
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-switch-on-connect";
    };
    bluetooth = {
      enable = true;
      hsphfpd.enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    uid = 1000;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword = "password";
    shell = pkgs.bash;
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
    ];
  };
  environment = {
    systemPackages = with pkgs;
      [
        zip
        curl
        wget
        unzip
        unrar
        git
        gzip
        vim
        gcc
        zlib
        gnumake
        cmake
        binutils
        appimage-run
        nordic
        home-manager
        libsForQt5.sddm-kcm
        libsForQt5.kwallet
        libsForQt5.kwallet-pam
      ] ++ [
        themes.nordic-custom-theme
      ];
  };
  programs = {
    kdeconnect.enable = true;
    dconf.enable = true;
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = ["root" "@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nix;
  };
  system = {
    stateVersion = "22.11";
    autoUpgrade.enable = true;
  };
}