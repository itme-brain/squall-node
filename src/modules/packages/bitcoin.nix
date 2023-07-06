{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "bitcoin";
  version = "24.1";

  src = fetchFromGitHub {
    owner = "bitcoin";
    repo = "bitcoin";
    rev = "v${version}";
    hash = "sha256-inm+GUlhTFkUB9LusUK6ZhYvU9c0gHCZfXSAbrPAdzE=";
  };

  meta = with lib; {
    description = "Bitcoin Core integration/staging tree";
    homepage = "https://github.com/bitcoin/bitcoin";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
