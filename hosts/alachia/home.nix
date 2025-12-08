{ config, pkgs, userName, hostName, themeName, ... }:

{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "25.11";
  imports = [
    ../../modules/desktop.nix
    ../../components/hosts/alachia/hyprland.nix
  ];
}
