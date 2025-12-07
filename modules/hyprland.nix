{ inputs, pkgs, userName, hostName, ... }:

let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in

{
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
      bind = [
        "$mod, RETURN, exec, ghostty"
        "$mod CTRL SHIFT, q, killactive"
      ];
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

  #home.file.".config/hypr".source = ./config/hypr;
  #home.file.".config/hypr/monitors.conf".source = ./config/hosts/${hostName}/hypr/monitors.conf;
}
