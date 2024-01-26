{
  description = "Squall - Bitcoin Node";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager= {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager}:
  flake-utils.lib.eachDefaultSystem
  (system:
  let
    pkgs = import nixpkgs {
      inherit system;
    };


  in with pkgs;
  {
    systemConfig = {
      inherit system pkgs;
      modules = [ 
        .src/backend/modules/system
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
