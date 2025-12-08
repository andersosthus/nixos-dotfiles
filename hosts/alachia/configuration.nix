{ config, lib, pkgs, inputs, userName, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/hyprland";
in

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  services.greetd = {
    enable = true;
    settings = {
      initial_session  = {
        command = "${session}";
        user = "${userName}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };
  # Laptop specific settings
  powerManagement.enable = true;
  #powerManagement.powerTop.enable = true;
  services.auto-cpufreq.enable = true;
  # End laptop specific settings

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "alachia";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  users.users.grapz = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.getty.autologinUser = "grapz";
  services.openssh.enable = true;

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    ghostty
    waybar
    hyprpaper
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  programs.firefox.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.git.config = {
    url."https://github.com/" = {
      insteadOf = [ "gh:" "github:" ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

