{
  description = "Squall - Bitcoin Node";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem
  (system:
  let
    pkgs = import nixpkgs { inherit system; };

  in with pkgs;
  {
    nixosConfigurations.node = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules = [ .src/backend/modules/system
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.squall = import .src/backend/modules/home;
        }
      ];
    };

    devShells.default = callPackage ./shell.nix { };
  });
}
