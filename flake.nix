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
      system = "x86_64-linux";

      hostname = "jenny";
      username = "jenny";
      sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrHB7G59MASG6JjFdUyuEMxfmttXAKqRLMudWlrt1h2bcA7aHCU32v/iQzOjzw3w26NLEKTY07CjLJq2/2lkd4QWMxUgMHj4AfcuoZm38Hw5aBsE4cz/A+zleK2sB7i/3iCWcBFoExkt+gE+F99mBqZrt+Ei5BdzD60AU2epcHjcHeEj7g94DL7grQI1NcoD9ygApT0v0lJd0MTB6Yum6AstsrbrSYnLo/lHEv/aHz6kEN7AWEQK+kqpUuaawHsh8grlaCvUfM3zmThangpxbNLDRtLhfrIImL9OE9oYnysZN03x+5rZOjjoSw3eTkcAHYfeQ1+XqkIcEYyd0LN1q/X/nQBHyExfsVsRUkpdPLUqjGdbMjxM4Kv49BcAvbY41SIOiWG75YmvMnoHivvulCmmDJJ3WbAfSE3Q6dliD2VbZZvvXdEV2tc16EGETpJB5rpxNT2l2umkdqFeqBEkb/3D4EjNFsIln+pI+E4mWSB43au9eqWp2tqXAx+hL/yic= dog0sd@pm.me";
      hashedPassword = null; # mkpasswd -m sha-512

      specialArgs = { inherit inputs hostname username sshKey hashedPassword; };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
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
