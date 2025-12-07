{ theme, ... }:

{
  home.file.".config/theme".source = ./theme/${theme};
}
