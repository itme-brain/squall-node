{ pkgs, ... }:

{ import = [
    ./locale.nix
    ./network.nix
    ./users.nix
    ./services
  ];
  
  system.stateVersion = "23.05";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "squall" ];
    };
  };

  modules = {
    bitcoin.enable = true;
    lightning.enable = true;
    electrum.enable = true;
    gui.enable = true;
  };
}
