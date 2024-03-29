{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
in {
  options.packages.enable = lib.mkEnableOption "enable packages";

  config = lib.mkIf config.packages.enable {
    home.packages = let
      common = with pkgs; [
        ansible
        cachix
        fd
        gh
        graphviz
        grex
        jq
        just
        kubectl
        kubernetes-helm
        mc
        minikube
        opentofu
        pandoc
        parallel
        quarto
        ripgrep
        tectonic
        terraform
        tokei
      ];
      darwin = with pkgs; [
        maven
        pngpaste
        terragrunt
      ];
      desktop = with pkgs;
        [
          bashly
          bitwarden
          bruno
          chromium
          curtail
          dbeaver
          deluge
          droidcam
          evince
          firefox
          gcolor3
          gnuplot
          gparted
          grim
          hugo
          libqalculate
          libreoffice
          nwg-displays
          obsidian
          pavucontrol
          phockup
          quickemu
          qview
          satty
          slurp
          swaybg
          ventoy
          vlc
          zotero
        ]
        ++ (with pkgs.xfce; [
          thunar
          thunar-volman
          thunar-archive-plugin
        ]);
    in
      if isDarwin
      then common ++ darwin
      else common ++ desktop;
  };
}
