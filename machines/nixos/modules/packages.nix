{pkgs, ...}: {
  home.packages =
    (with pkgs; [
      ansible
      bashly
      beekeeper-studio
      bitwarden
      bruno
      celluloid
      chromium
      coursier
      docker-compose
      droidcam
      evince
      eza
      firefox
      fragments
      gh
      git
      gthumb
      hugo
      imagemagick
      insync
      kubectl
      kubernetes-helm
      lazydocker
      micromamba
      minikube
      ncdu
      neovide
      obsidian
      onlyoffice-bin
      parallel
      quarto
      spot
      tealdeer
      tectonic
      terraform
      ueberzugpp
      ventoy
      veracrypt
      wezterm
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
