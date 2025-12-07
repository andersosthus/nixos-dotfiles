{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$activeBorderColor" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "$inactiveBorderColor" = "rgba(595959aa)";
      "$shadowColor" = "rgba(1a1a1aee)";
    };
  };
}
