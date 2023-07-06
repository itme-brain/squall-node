{ config, pkgs, ... }:
let
  User = "electrum";
  Group = "bitcoin";

in
{
  systemd.services.electrs = {
    enable = true;
    description = "Electrs Bitcoin indexer";
    
    after = ["bitcoind"];
    requires = ["bitcoind"];
    
    serviceConfig = {
      inherit User;
      inherit Group;

      ExecPre = "${PATH}/bin/sleep 5";
      ExecStart = "${pkgs.electrs}/bin/electrs --conf /var/electrum/.electrs/config.toml";
    };
    
    wantedBy = [ "multi-user.target" ];
  };
}
