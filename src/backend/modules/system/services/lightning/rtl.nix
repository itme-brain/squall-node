{ lib , stdenv , fetchFromGitHub }:

let 
  rtl = stdenv.mkDerivation rec {
    pname = "ride-the-lightning";
    version = "0.14.0";

    src = fetchFromGitHub {
      owner = "Ride-The-Lightning";
      repo = "RTL";
      rev = "v${version}";
      sha256 = "OZsAnfbKzHnTHx81dbYl0Ga5xH7IU0qAUiGdoIhzr38=";
    };

    meta = with lib; {
      description = "Ride The Lightning - A full function web browser app for LND, C-Lightning and Eclair";
      homepage = "https://github.com/Ride-The-Lightning/RTL";
      license = licenses.mit;
    };
  };

in
{

}
