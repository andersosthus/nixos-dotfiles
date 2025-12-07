{ inputs, pkgs, userName, hostName, ... }:

let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
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
