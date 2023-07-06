{ config, pkgs, ... }:
let
  User = "core";
  Group = "bitcoin";

in
{
  systemd.services.bitcoind.mainnet = {
    enable = true;
    description = "Bitcoin daemon";

    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    
    serviceConfig = {
      inherit User;
      inherit Group;

      ExecStart = "${pkgs.bitcoincore}/bin/bitcoind 
                      -conf=/var/core/.bitcoin/bitcoin.conf
                      -pid=/run/bitcoind/bitcoind.pid
                      -datadir=/var/core/.bitcoin
                      ";
      
      PermissionsStartOnly=true;
      Type = [ "forking" ];
      
      #TODO: Finish Configuring Bitcoin Service, setup a bitcoincore package compiled from source
    };

    wantedBy = [ "multi-user.target" ];
  };   
}
