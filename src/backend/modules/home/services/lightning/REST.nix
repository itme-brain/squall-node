{ pkgs, lib, fetchFromGithub }:
with lib;

let
  clightning-rest = stdenv.mkDerivation rec {
    pname = "clightning-rest";
    version = "some_version"; # replace with the version you want

    src = fetchFromGitHub {
      owner = "Ride-The-Lightning";
      repo = "c-lightning-REST";
      rev = "v${version}";
      sha256 = "some_sha256"; # replace with correct hash
    };

  };

in
{

}
