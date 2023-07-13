{ pkgs, ... }:

{
  imports = [
    ./modules/.
  ];

  nix = {
    packages = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system.stateVersion = "23.05";
}
