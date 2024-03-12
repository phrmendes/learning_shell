{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    appimage-run
    binutils
    cmake
    coreutils-full
    curl
    gcc
    gnumake
    gnused
    gzip
    icu
    jdk21
    libuv
    nodejs_21
    psmisc
    python312
    rar
    ripgrep
    sqlite
    unrar
    unzip
    wget
    xclip
    zip
    zlib
  ];
}
