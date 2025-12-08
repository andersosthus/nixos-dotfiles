{ config, pkgs, userName, hostName, themeName, ... }:

{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "25.11";
  home.packages =
    with pkgs;
    [
    ];
  imports = [
    ../../modules/desktop.nix
    ../../components/hosts/alachia/hyprland.nix
  ];
}
