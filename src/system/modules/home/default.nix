{ ... }:

{
  programs.home-manager.enable = true;
  imports = [ (import ./services) ];
  home.stateVersion = "23.05";

  home.username = "squall";
  home.homeDirectory = "/home/squall";

  modules = {
    bitcoin.enable = true;
    lightning.enable = true;
    electrum.enable = true;
  };
}
