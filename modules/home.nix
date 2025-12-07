{ config, pkgs, userName, hostName, theme, ... }:

{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "25.11";
  home.packages =
    with pkgs;
    [
    ];
  imports = [
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./neovim.nix
  ];
}
