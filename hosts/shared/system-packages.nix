{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cachix
    coreutils-full
    file
    findutils
    gcc
    gzip
    mlocate
    p7zip
    protonup
    psmisc
    rar
    sqlite
    unar
    unzip
    wget
    wl-clipboard
    xdg-utils
    zip
  ];
}
