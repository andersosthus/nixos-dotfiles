{ themeName, ...}:

{
  imports = [
    ../themes/${themeName}/base.nix
    ../components/scripts.nix
    ../components/fish.nix
    ../components/git.nix
    ../components/hyprland.nix
    ../components/neovim.nix
  ];
}
