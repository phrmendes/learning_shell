{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI
    coursier
    exa
    fd
    feh
    gh
    gnome-extensions-cli
    hugo
    jdk20
    joshuto
    lazydocker
    ncdu
    pandoc
    pass
    # quarto
    rename
    ripgrep
    slides
    sqlite
    tealdeer
    tectonic
    terraform
    # GUI
    bitwarden
    deluge
    onlyoffice-bin
    thunderbird
    vlc
    zotero
    # language-servers
    ansible-language-server
    efm-langserver # generic
    helm-ls
    ltex-ls # language tool
    lua-language-server
    marksman # markdown
    metals # scala
    nil # nix
    ruff-lsp # python
    taplo # toml
    terraform-ls
    texlab # latex
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.pyright
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    # linters
    nodePackages.jsonlint
    shellcheck
    statix # nix
    yamllint
    # formatters
    alejandra # nix
    ruff # python
    scalafmt
    shfmt
    stylua # lua
    nodePackages.prettier # yaml, json, markdown
  ];
}
