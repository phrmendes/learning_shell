{
  config,
  pkgs,
  ...
}: let
  user = "phrmendes";
in {
  imports = [
    ./modules/bat.nix
    ./modules/btop.nix
    ./modules/direnv.nix
    ./modules/flameshot.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/home-manager.nix
    ./modules/lazygit.nix
    ./modules/packages.nix
    ./modules/starship.nix
    ./modules/symlinks.nix
    ./modules/zathura.nix
    ./modules/zoxide.nix
    ./modules/zsh.nix
  ];
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "23.05";
    sessionVariables = {
      VISUAL = "${pkgs.helix}/bin/hx";
      TERMINAL = "/usr/bin/wezterm";
      SUDO_EDITOR = "${pkgs.helix}/bin/hx";
    };
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };
}