{ config, pkgs, lib, stdenv, fetchTarball, ... }:
with lib; 

let
  cfg = config.modules.bitcoin;
  User = "core";
  Group = "bitcoin";

  BitcoinCore = stdenv.mkDerivation {
    pname = "bitcoincore";
    version = "25.0";

    src = fetchTarball {
      url = "https://bitcoincore.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz";
      sha256 = "065ykx5cbrjn92blz65w15a2m4nkg2f9xmmz1j3qhx37j6lali4m";
    };

    phases = [ "unpackPhase" "installPhase" ];

    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';

    meta = with lib; {
      description = "Bitcoin Core integration/staging tree";
      homepage = "https://bitcoincore.org/";
      license = licenses.mit;
    };
  };

in
{
  options.modules.bitcoin = { enable = mkEnableOption "bitcoin"; };
  config = mkIf cfg.enable {
    systemd.services.bitcoind.mainnet = {
      enable = true;
      description = "Bitcoin daemon";

      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        inherit User;
        inherit Group;

        ExecStart = "${BitcoinCore}/bin/bitcoind 
                        -conf=/var/core/.bitcoin/bitcoin.conf
                        -pid=/run/bitcoind/bitcoind.pid
                        -datadir=/var/core/.bitcoin
                        ";
        
        PermissionsStartOnly=true;
        Type = [ "forking" ];
      };

      wantedBy = [ "multi-user.target" ];
    };   
  };
}
