{pkgs, ...}: {
  home.packages = with pkgs; [
    ansible
    asdf-vm
    pipx
    bitwarden
    caffeine-ng
    copyq
    deluge
    exa
    fd
    gh
    gnome-extensions-cli
    hugo
    mlocate
    ncdu
    onlyoffice-bin
    pandoc
    pipr
    podman
    podman-compose
    podman-tui
    quarto
    rename
    ripgrep
    sbt
    scala
    scala-cli
    sqlite
    tealdeer
    tectonic
    thunderbird
    vlc
    xclip
    zathura
    zotero
  ];
}
