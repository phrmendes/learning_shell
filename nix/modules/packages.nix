{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI
    atool
    coursier
    duckdb
    exiftool
    eza
    fd
    gh
    gnome-extensions-cli
    hugo
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pt_BR
    jdk20
    joshuto
    lazydocker
    micromamba
    ncdu
    pandoc
    parallel
    poppler_utils
    quarto
    rename
    ripgrep
    scala_3
    slides
    sqlite
    tealdeer
    tectonic
    terraform
    weylus
    xclip
    xlsx2csv
    # GUI
    bitwarden
    caffeine-ng
    chromium
    deluge
    droidcam
    libreoffice
    thunderbird
    vlc
    xournalpp
    zotero
  ];
}
