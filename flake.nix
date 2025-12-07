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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, agenix, ... }:
  let
    mkHost = { hostName, userName, theme, system, extraModules ? [] }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostName userName theme; };

        modules = [
          ./hosts/alachia/configuration.nix
          ./hosts/alachia/disko-config.nix

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
                inherit inputs userName hostName theme;
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
        theme = "tokyo-nights";
        system = "x86_64-linux";
      };
    };
  };
}
