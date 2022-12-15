{ config, pkgs, ... }:

let
  user = "prochame";
in {
  imports = [
    <home-manager/nix-darwin>
    ./home.nix 
  ];
  users.users.${user} = {
    home = "/Users/${user}";
    description = "Pedro Mendes";
    shell = pkgs.zsh;
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnsupportedSystem = true;
    };
  };
  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      tree
      home-manager
    ];
    shellAliases = {
      mkdir = "mkdir -p";
      ls = "exa --icons";
      cat = "bat";
      lv = "lvim";
      lg = "lazygit";
      stow_dotfiles = "stow --target=$HOME --dir=$HOME/Projects/bkps/ --stow .dotfiles";
    };
  };
  fonts = {
     fontDir.enable = true;
     fonts = with pkgs; [ (nerdfonts.override { fonts = [ "SourceCodePro" ]; }) ];
   };
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.upgrade = true;
    taps = [ "homebrew/cask" ];
    casks = [
      "keepassxc"
      "mpv"
      "slack"
      "caffeine"
      "maccy"
      "amethyst"
      "iterm2"
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    enableFzfCompletion = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = true;
    loginShellInit = ''
      export PATH=$HOME/.local/bin:$PATH
      eval "$($HOME/.nix-profile/bin/starship init zsh)"
    '';
  };
  system = {
    defaults = {
      dock = {
        autohide = true;
        orientation = "right";
        showhidden = true;
        mru-spaces = false;
        show-recents = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = false;
      };
    };
  };
  services.nix-daemon.enable = true;
}
