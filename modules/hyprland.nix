{ pkgs, theme, ... }:

{
  imports = [
    ../themes/${theme}/hyprland.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;
    portalPackage = null;
    plugins = [
      pkgs.hyprlandPlugins.hyprsplit
    ];
    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = dwindle;

        col = {
          active_border = ;
          inactive_border = ;
        };
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = ;
        };

        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          special = true;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      master = {
        new_status = master;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        anr_missed_pings = 3;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
      };

      cursor = {
        hide_on_key_press = true;
      };

      plugin = {
        hyprsplit = {
          num_workspaces = 6;
          persistent_workspaces = true;
        };
      };

      input = {
        kb_layout = no;
        kb_options = "compose:caps";

        repeat_rate = 40;
        repeat_delay = 600;

        numlock_by_default = true;

        follow_mouse = 1;
      };

      exec-once = [
        hyprsunset
      ];

      env = [
        XCURSOR_SIZE = 24;
        HYPRCURSOR_SIZE = 24;
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      ecosystem = {
        no_update_news = true;
      };

      windowrule = [
        "scrolltouchpad 0.2, class:com.mitchellh.ghostty"
        "suppressevent maximize, class:.*"
        "opacity 0.97 0.9, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      bind = [
        "$mod, RETURN, exec, ghostty"
        "$mod CTRL SHIFT, Q, killactive"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod CTRL SHIFT, N, movewindow, mon:+1"
        "$mod CTRL SHIFT ALT, G, grabrougewindows"
        "$mod CTRL SHIFT, S, swapactiveworkspaces, current +1"
        "$mod, S, swapwithmaster"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, split:workspace, ${toString ws}"
            "$mod, code:1${toString i}, split:movetoworkspacesilent, ${toString ws}"
          ]
        ))
      );
    };
  };

  programs.kitty = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  services.hypridle = {
    enable = true;
  };
}
