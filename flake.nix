{
  description = "Jenny NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      vars = import ./variables.nix;
      system = vars.system;
      specialArgs = { inherit inputs; } // vars;
    in
    {
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            nixpkgs.overlays = [ (final: prev: { unstable = final; }) ];
          }
        ];
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    };
}
