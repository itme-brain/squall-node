{ pkgs, ... }:

{
  imports = [
    ./modules/.
  ];

# TODO: Move the services from system level to user level, add home-manager and change user file to user directory

  nix = {
    packages = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system.stateVersion = "23.05";
}
