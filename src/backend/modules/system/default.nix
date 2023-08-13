{ pkgs, ... }:

{ import = [
    ./locale.nix
    ./network.nix
    ./users.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "bryan" ];
    };
  };
}
