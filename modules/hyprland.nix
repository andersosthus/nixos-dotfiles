{ inputs, pkgs, userName, hostName, ... }:

let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
in

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${userName}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      hyprland-split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
  };

  wayland.win

  programs.kitty = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  programs.hyprsunset = {
    enable = true;
  };

  programs.hypridle = {
    enable = true;
  };

  wayland.windowManager.hyprland.plugins = [
    inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.
  ];

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/hypr/monitors.conf".source = ./config/hosts/${hostName}/hypr/monitors.conf;
}
