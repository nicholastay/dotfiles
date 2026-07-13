{ stdenv, fetchFromGitHub }:

let
  version = "0.1.2";
in
stdenv.mkDerivation {
  pname = "passgen";
  inherit version;

  src = fetchFromGitHub {
    owner = "nicholastay";
    repo = "passgen";
    rev = "v${version}";
    hash = "sha256-5lxTlwJjebNpQK426zBeYLuBxe5baeEpGW8dI7W6Gec=";
  };

  installPhase = ''
    make install PREFIX=$out
  '';
}
