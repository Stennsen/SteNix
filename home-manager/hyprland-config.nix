{ pkgs, lib, config, ... }:

{

  imports = [
    ./hypridle-config.nix
    ./hyprlock-config.nix
  ];

  programs.waybar.enable = true;
  programs.rofi.enable = true;
  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = with pkgs; [
      #hyprlandPlugins.hyprexpo
    ];
    settings = {
      ###############
      ### startup ###
      ###############
      exec-once = [
        "hypridle"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment"
        "${pkgs.dunst}/bin/dunst"
      ];

      env = with lib.stylix; [
        # "bitdepth,10"
        #"HYPRCURSOR_THEME,catppuccin-mocha-blue"
        #"HYPRCURSOR_SIZE,32"
      ];

      ################
      ### monitors ###
      ###############
      monitor = [
        "eDP-1,preferred,0x0,1"
        ",preferred,auto,1"
      ];

      ###################
      ### decorations ###
      ###################
      decoration = {
        rounding = 16;
        blur = {
          enabled = true;
          size = 2;
        };
      };

      #####################
      ### standard apps ###
      #####################
      "$terminal" = "alacritty";

      "$menu_name" = "rofi";
      "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons";

      "$screenshot" = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';

      #############
      ### input ###
      #############
      input = {
        touchpad = {
	      natural_scroll = true;
	      clickfinger_behavior = true;
	      tap-to-click = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_touch = true;
      };

      ################
      ### keybinds ###
      ################
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
      bindr = [
    	"SUPER, SUPER_L, exec, pkill $menu_name || $menu"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bind = [

        # Plugins

        # mute
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$mainMod, Print, exec, $screenshot"

	    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
	    "$mainMod, Q, exec, $terminal"
	    "$mainMod, C, killactive,"
	    "$mainMod, M, exit,"
	    "$mainMod, E, exec, $fileManager"
	    "$mainMod, V, togglefloating,"
	    #"$mainMod, P, pseudo," # dwindle
	    "$mainMod, S, togglesplit," # dwindle
         	# Move focus with mainMod + arrow keys
	    "$mainMod, H, movefocus, l"
	    "$mainMod, L, movefocus, r"
	    "$mainMod, K, movefocus, u"
	    "$mainMod, J, movefocus, d"
         	# move windows
	    "$mainMod SHIFT, H, movewindow, l"
	    "$mainMod SHIFT, L, movewindow, r"
	    "$mainMod SHIFT, K, movewindow, u"
	    "$mainMod SHIFT, J, movewindow, d"

		"$mainMod,F,fullscreen"
      ];

      #bindl = [
      #  ",switch:off:[1a77d60],exec, (${lock_session}) && systemctl suspend"
      #];
    };
  };
}
