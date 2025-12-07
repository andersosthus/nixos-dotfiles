{ config, pkgs, ... }:

{
  home.username = "grapz";
  home.homeDirectory = "/home/grapz";
  home.stateVersion = "25.11";
  home.packages =
    with pkgs;
    [
      git
    ];
  programs.fish = {
    enable = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Anders Osthus";
        email = "anders@osthus.me";
      };
    };
    settings = {
      init.defaultBranch = "main";
    };
  };
}
