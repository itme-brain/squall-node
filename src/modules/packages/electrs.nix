{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "electrs";
  version = "0.9.13";

  src = fetchFromGitHub {
    owner = "romanz";
    repo = "electrs";
    rev = "v${version}";
    hash = "sha256-GV/cwFdYpXJXRTgdVfuzJpmwNhe0kVJnYAJe+DPmRV8=";
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
}
