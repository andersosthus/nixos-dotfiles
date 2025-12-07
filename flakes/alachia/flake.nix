{
  description = "Extras for Alachia";

  inputs = {
    nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ...}:
  {
    nixosModules.default = { config, pkgs, ...}: {
      services.power-profiles-daemon.enable = true;

      environment.systemPackages = with pkgs; [
        powertop
      ];
    };
  };
}
