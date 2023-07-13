{ config, pkgs, lib, rustPlatform, fetchFromGitHub, ... }:
with lib;
let
  cfg = config.modules.electrum;
  User = "electrum";
  Group = "bitcoin";
  Electrum = rustPlatform.buildRustPackage rec {
    pname = "electrs";
    version = "0.10.0-rc.1";

    src = fetchFromGitHub {
      owner = "romanz";
      repo = "electrs";
      rev = "v${version}";
      hash = "sha256-1rydiazn25f0lw24j05nnjaivmk0d2d8l647inxb2n86pfm9azgz";
    };

    cargoHash = "sha256-eQAizO26oQRosbMGJLwMmepBN3pocmnbc0qsHsAJysg=";

    nativeBuildInputs = [
      rustPlatform.bindgenHook
    ];

    meta = with lib; {
      description = "An efficient re-implementation of Electrum Server in Rust";
      homepage = "https://github.com/romanz/electrs";
      license = licenses.mit;
      maintainers = with maintainers; [ ];
    };
  };
in
{
  options.modules.bitcoin = { enable = mkEnableOption "bitcoin"; };
  config = mkIf cfg.enable {
    systemd.services.electrs = {
      enable = true;
      description = "Electrs Bitcoin indexer";
      
      after = ["bitcoind"];
      requires = ["bitcoind"];
      
      serviceConfig = {
        inherit User;
        inherit Group;

        ExecPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = "${Electrum}/bin/electrs --conf /var/electrum/.electrs/config.toml";
      };
      
      wantedBy = [ "multi-user.target" ];
    };
  };
}
