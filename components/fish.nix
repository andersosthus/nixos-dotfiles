{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAbbrs = {
      mkdir = "mkdir -p";
      df = "df -h";
      du = "du -h";
      k = "kubectl";
      gco = "git checkout";
    };

    plugins = [
      {
        name = "z";
        package = pkgs.fishPlugins.z.src;
      }
      {
        name = "fzf-fish";
        package = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };

  home.shell {
    enableFishIntegration = true;
  };

  programs.fzf = {
    enableFishIntegration = true;
  };
}
