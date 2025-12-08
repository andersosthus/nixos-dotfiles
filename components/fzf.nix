{
  programs.fzf = {
    enable = true;

    defaultCommand = "rg --files --hidden --follow --no-ignore-vcs";
    defaultOptions = [
      "--height 75%"
      "--layout=reverse"
      "--border"
    ];

    # https://github.com/tinted-theming/tinted-fzf/blob/main/fish/base16-tokyo-night-dark.fish
    colors = {
      bg = "${theme.color00.hex}";
      "bg+" = "${theme.color01.hex}";
      spinner = "${theme.color10.hex}";
      hl = "${theme.color13.hex}";
      fg = "${theme.color04.hex}";
      header = "${theme.color13.hex}";
      info = "${theme.color10.hex}";
      pointer = "${theme.color12.hex}";
      marker = "${theme.color12.hex}";
      "fg+" = "${theme.color06.hex}";
      prompt = "${theme.color10.hex}";
      "hl+" = "${theme.color13.hex}";
    };
  };
}
