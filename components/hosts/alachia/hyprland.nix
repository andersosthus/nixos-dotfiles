{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        touchpad = {
          natural_scroll = false;
          scroll_factor = 0.4;
          disable_while_typing = true;
        };
      };
    };
  };
}
