{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
in {
  options.symlinks.enable = lib.mkEnableOption "enable symlinks";

  config = lib.mkIf config.symlinks.enable {
    home.file = let
      common = {
        ".local/share/mc/skins/catppuccin.ini".source = ../dotfiles/mc/skin/catppuccin.ini;
        ".config/mc".source = ../dotfiles/mc;
        ".config/nvim" = {
          source = ../dotfiles/nvim;
          recursive = true;
        };
      };
      darwin = {
        ".amethyst.yml".source = ../dotfiles/amethyst.yml;
      };
      desktop = {
        ".phrmendes.face.icon".source = ../dotfiles/avatar.png;
      };
    in
      if isDarwin
      then common // darwin
      else common // desktop;
  };
}