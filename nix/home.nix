{pkgs, ...}: let
  username = "phrmendes";
in {
  imports = [
    ./modules/bat.nix
    ./modules/btop.nix
    ./modules/copyq.nix
    ./modules/direnv.nix
    ./modules/flameshot.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/home-manager.nix
    ./modules/lazygit.nix
    ./modules/neovim.nix
    ./modules/packages.nix
    ./modules/pyenv.nix
    ./modules/starship.nix
    ./modules/symlinks.nix
    ./modules/tmux.nix
    ./modules/vscodium.nix
    ./modules/zathura.nix
    ./modules/zoxide.nix
    ./modules/zsh.nix
  ];
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
    sessionVariables = {
      EDITOR = "${pkgs.neovim-unwrapped}/bin/nvim";
      VISUAL = "${pkgs.neovim-unwrapped}/bin/nvim";
      TERMINAL = "flatpak run org.wezfurlong.wezterm";
      SUDO_EDITOR = "${pkgs.neovim-unwrapped}/bin/nvim";
    };
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };
}
