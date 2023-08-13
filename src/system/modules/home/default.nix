{ ... }:

#TODO: Move the services to the system level since they
#      create users and modify priveledges

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
