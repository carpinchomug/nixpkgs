{ lib
, stdenv
, fetchFromGitHub
, imake
, gccmakedep
, libX11
, libXext
}:

stdenv.mkDerivation rec {
  version_name = "1.2.hanami.6";
  version = "1.2.6";
  pname = "oneko";
  src = fetchFromGitHub {
    owner = "IreneKnapp";
    repo = "oneko";
    rev = version_name;
    sha256 = "0vx12v5fm8ar3f1g6jbpmd3b1q652d32nc67ahkf28djbqjgcbnc";
  };
  nativeBuildInputs = [ imake gccmakedep ];
  buildInputs = [ libX11 libXext ];

  makeFlags = [ "BINDIR=$(out)/bin" "MANPATH=$(out)/share/man" ];
  installTargets = [ "install" "install.man" ];

  meta = with lib; {
    description = "Creates a cute cat chasing around your mouse cursor";
    longDescription = ''
    Oneko changes your mouse cursor into a mouse
    and creates a little cute cat, which starts
    chasing around your mouse cursor.
    When the cat is done catching the mouse, it starts sleeping.
    '';
    homepage = "https://github.com/IreneKnapp/oneko";
    license = with licenses; [ publicDomain ];
    maintainers = with maintainers; [ xaverdh irenes ];
    platforms = platforms.unix;
    # never built on aarch64-darwin since first introduction in nixpkgs
    broken = stdenv.isDarwin && stdenv.isAarch64;
  };
}
