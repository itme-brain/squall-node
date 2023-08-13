{ lib, stdenv , fetchFromGitHub }:

let
  cln-rest = stdenv.mkDerivation rec {
    pname = "c-lightning-rest";
    version = "0.10.5";

    src = fetchFromGitHub {
      owner = "Ride-The-Lightning";
      repo = "c-lightning-REST";
      rev = "v${version}";
      sha256 = "QLpuSN/SVTJ16WT6xgV/BK763dYzdC1UKK74PoHQNPU=";
    };

    meta = with lib; {
      description = "REST APIs for Core Lightning written with node.js";
      homepage = "https://github.com/Ride-The-Lightning/c-lightning-REST";
      license = licenses.mit;
    };
  };

in 
{

}
