{pkgs, ...}: {
  home.packages =
    (with pkgs; [
      ansible
      appimage-run
      bashly
      beekeeper-studio
      binutils
      bitwarden
      bruno
      chromium
      cmake
      coursier
      curl
      docker-compose
      droidcam
      evince
      eza
      fd
      firefox
      fragments
      gcc
      gh
      git
      gnumake
      gnupg
      gzip
      hugo
      jdk21
      kubectl
      kubernetes-helm
      lazydocker
      micromamba
      minikube
      ncdu
      nodejs_21
      obsidian
      onlyoffice-bin
      parallel
      peek
      python312
      quarto
      ripgrep
      tealdeer
      terraform
      unrar
      unzip
      vlc
      wezterm
      wget
      xclip
      zip
      zlib
      zotero
    ])
    ++ (with pkgs.gnome; [
      file-roller
      gnome-calculator
      gnome-disk-utility
      gnome-screenshot
      gnome-tweaks
      nautilus
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      clipboard-indicator
      espresso
      forge
    ]);
}
