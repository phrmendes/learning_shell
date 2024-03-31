{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hyprland.enable = lib.mkEnableOption "enable hyprland";

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = let
      inherit (lib) getExe;
      copyq = getExe pkgs.copyq;
      grim = getExe pkgs.grim;
      kitty = getExe pkgs.kitty;
      playerctl = getExe pkgs.playerctl;
      powermenu = getExe pkgs.rofi-power-menu;
      satty = getExe pkgs.satty;
      slurp = getExe pkgs.slurp;
      swaybg = getExe pkgs.swaybg;
      dunstctl = "${pkgs.dunst}/bin/dunstctl";
      swayosd-client = "${pkgs.swayosd}/bin/swayosd-client";
      syncthingtray = "${pkgs.syncthingtray}/bin/syncthingtray";
      systemctl = "${pkgs.systemd}/bin/systemctl";
      wallpaper = ../dotfiles/wallpaper.png;
      colors = import ./catppuccin.nix;
      workspaces = [1 2 3 4 5 6 7 8 9];
      switchToWorkspace = map (x: "SUPER, ${builtins.toString x}, workspace, ${builtins.toString x}") workspaces;
      moveToWorkspaceSilent = map (x: "SUPER SHIFT CTRL, ${builtins.toString x}, movetoworkspacesilent, ${builtins.toString x}") workspaces;
      moveToWorkspace = map (x: "SUPER SHIFT, ${builtins.toString x}, movetoworkspace, ${builtins.toString x}") workspaces;
      startupScript = pkgs.writeShellScriptBin "start" ''
        ${swaybg} --image ${wallpaper} --mode fill
        ${systemctl} --user restart syncthingtray
        ${systemctl} --user restart copyq
      '';
      screenshotScript = pkgs.writeShellScriptBin "screenshot" ''
        print_path="$HOME/Pictures/Screenshots"
        filename=$(date "+%Y%m%d-%H:%M:%S")

        ${grim} -g "$(${slurp})" - | ${satty} --filename - --output-filename "$print_path/$filename".png
      '';
    in {
      enable = true;
      settings = with colors.catppuccin.palette; {
        exec-once = "${startupScript}/bin/start";
        input = {
          kb_layout = "us,br";
          kb_model = "pc104";
          kb_options = "grp:alt_space_toggle";
          kb_rules = "evdev";
          follow_mouse = 1;
          sensitivity = 0;
        };
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
          resize_on_border = true;
          "col.active_border" = "rgba(${blue}ff) rgba(${green}ff) 60deg";
        };
        decoration = {
          active_opacity = 1;
          inactive_opacity = 0.9;
          rounding = 10;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(${base}ff)";
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };
        monitor = [
          "DP-2,1366x768,0x0,auto"
          "HDMI-A-1,1920x1080,1366x0,auto"
        ];
        windowrulev2 = [
          "float,stayfocused,class:(gcolor3)"
          "float,stayfocused,class:(nwg-displays)"
          "float,stayfocused,class:(pavucontrol)"
          "float,stayfocused,class:(satty)"
          "float,stayfocused,opaque,class:(copyq)"
          "float,stayfocused,rounding 10,class:(rofi)"
          "opaque,class:(chromium)"
          "opaque,class:(firefox)"
          "opaque,class:(vlc)"
        ];
        workspace = [
          "1,monitor:HDMI-A-1"
          "2,monitor:HDMI-A-1"
          "3,monitor:HDMI-A-1"
          "4,monitor:HDMI-A-1"
          "5,monitor:HDMI-A-1"
          "6,monitor:HDMI-A-1"
          "7,monitor:HDMI-A-1"
          "8,monitor:HDMI-A-1"
          "9,monitor:DP-2"
        ];
        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];
        binde = [
          ",XF86AudioMute,exec,${swayosd-client} --output-volume mute-toggle"
          ",XF86AudioRaiseVolume,exec,${swayosd-client} --output-volume raise"
          ",XF86AudioLowerVolume,exec,${swayosd-client} --output-volume lower"
          # resize
          "SUPER ALT,left,resizeactive,-20 0"
          "SUPER ALT,right,resizeactive,20 0"
          "SUPER ALT,up,resizeactive,0 -20"
          "SUPER ALT,down,resizeactive,0 20"
        ];
        bind =
          [
            # apps
            "SUPER,C,exec,rofi -show calc -modi calc -no-show-match -no-sort"
            "SUPER,E,exec,rofi -show emoji -modi emoji"
            "SUPER,F,exec,rofi -show filebrowser"
            "SUPER,S,exec,rofi -show recursivebrowser"
            "SUPER,space,exec,rofi -show drun"
            "SUPER,tab,exec,rofi -show window"
            ''SUPER,escape,exec,rofi -show power-menu -modi "power-menu:${powermenu} --choices=shutdown/reboot/lockscreen/suspend"''
            ",print,exec,${screenshotScript}/bin/screenshot"
            "SUPER,return,exec,${kitty}"
            "SUPER SHIFT,C,exec,${dunstctl} close-all"
            "SUPER SHIFT,V,exec,${copyq} menu"
            # general operations
            "SUPER,G,togglegroup"
            "SUPER,P,pseudo"
            "SUPER,Q,killactive"
            "SUPER,T,togglesplit"
            "SUPER,Z,fullscreen"
            "SUPER SHIFT,F,togglefloating"
            "SUPER SHIFT,G,changegroupactive"
            # windows
            "SUPER,H,movefocus,l"
            "SUPER,J,movefocus,d"
            "SUPER,K,movefocus,u"
            "SUPER,L,movefocus,r"
            "SUPER SHIFT,H,movewindow,l"
            "SUPER SHIFT,L,movewindow,r"
            "SUPER SHIFT,K,movewindow,u"
            "SUPER SHIFT,J,movewindow,d"
            # workspaces
            "SUPER CTRL,H,workspace,r-1"
            "SUPER CTRL,L,workspace,r+1"
            "SUPER SHIFT CTRL,H,movetoworkspace,r-1"
            "SUPER SHIFT CTRL,L,movetoworkspace,r+1"
            # music
            ",XF86AudioNext,exec,${playerctl} next"
            ",XF86AudioPlay,exec,${playerctl} play-pause"
            ",XF86AudioPrev,exec,${playerctl} previous"
          ]
          ++ switchToWorkspace
          ++ moveToWorkspace
          ++ moveToWorkspaceSilent;
      };
    };
  };
}
