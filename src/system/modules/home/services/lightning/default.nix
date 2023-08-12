{ pkgs, lib, config, fetchFromGitHub, autoreconfHook, pkgconfig, gmp, sqlite, python3, libffi, libsodium, ... }:
with lib;

let
  cfg = config.modules.lightning;
  User = "lightning";
  Group = "bitcoin";

  C-Lightning = stdenv.mkDerivation rec {
    pname = "c-lightning";
    version = "23.05.2";

    src = fetchFromGitHub {
      owner = "ElementsProject";
      repo = "lightning";
      rev = "v${version}";
      sha256 = "0kb09yjb4ir8nsm8njgb10lqp1806aaglhnf5fzfhr2bx9iibrff";
    };

    buildInputs = [ gmp sqlite pkgconfig python3 libffi libsodium ];

    nativeBuildInputs = [ autoreconfHook ];

    meta = {
      description = "Core Lightning — Lightning Network implementation focusing on spec compliance and performance";
      homepage = "https://github.com/ElementsProject/lightning";
      license = licenses.mit;
    };
  };
in
{

  options.modules.lightning = { enable = mkEnableOption "lightning"; };
  config = mkIf cfg.enable {
    users.users.lightning = {
      isSystemUser = true;
      shell = "sbin/nologin";
      group = "bitcoin";
    };

    users.groups.bitcoin = {};

    systemd.services.lightningd = {
      enable = true;
      description = "Core Lightning daemon";

      requires = [ "bitcoind.service" ];
      after = [ "bitcoind.service" "network-online.target" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        inherit User;
        inherit Group;

        ExecStartPre = "${pkgs.coreutils}/bin/sleep 10";
        ExecStart = "${C-Lightning}/bin/lightningd";

        PrivateTmp = "true";
        ProtectSystem = "full";
        NoNewPrivileges = "true";
        PrivateDevices = "true";

        Type = "forking";
        Restart = "always";
        TimeoutStopSec = "180s";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
