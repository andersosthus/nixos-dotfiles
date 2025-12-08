{
  description = "NixOS Awesome Setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, agenix, ... }:
  let
    mkHost = { hostName, userName, themeName, system, extraModules ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostName userName themeName; };

        modules = [
          ./hosts/${hostName}/configuration.nix
          ./hosts/${hostName}/disko-config.nix

          disko.nixosModules.disko

          home-manager.nixosModules.home-manager

          agenix.nixosModules.default

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName} = import ./modules/home.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit inputs userName hostName themeName;
              };
            };
          }
        ] ++ extraModules;
      };
  in
  {
    nixosConfigurations = {
      alachia = mkHost {
        hostName = "alachia";
        userName = "grapz";
        themeName = "tokyo-night";
        system = "x86_64-linux";
        extraModules = [
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
        ];
      };
    };
  };
}
