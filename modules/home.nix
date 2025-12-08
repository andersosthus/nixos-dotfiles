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
    ./scripts.nix
    ./fish.nix
    ./git.nix
    ./hyprland.nix
    ./neovim.nix
    ../themes/${themeName}/base.nix
  ];
}
