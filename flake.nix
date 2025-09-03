{
  description = "hdt-cpp as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; };
      let
        hdt-version = "88110cc24d4d7d07080b40325d1905fae999ef95";
        hdt-cpp = stdenv.mkDerivation {
          pname = "hdt";
          version = hdt-version;

          src = fetchFromGitHub {
            owner = "rdfhdt";
            repo = "hdt-cpp";
            rev = "${hdt-version}";
            sha256 = "sha256-KiMipqX/TgLmGYcRbGrpiFW2IVSFSxXwLjMobu8/w6Y=";
          };

          buildInputs = [ zlib serd ];

          nativeBuildInputs = [ autoreconfHook libtool pkg-config ];

          enableParallelBuilding = true;

          meta = with lib; {
            homepage = "http://www.rdfhdt.org/";
            description =
              "Header Dictionary Triples (HDT) is a compression format for RDF data that can also be queried for Triple Patterns";
            license = licenses.lgpl21;
            platforms = platforms.linux;
          };
        };
      in {
        packages = {
          default = hdt-cpp;
        };
      });

}
