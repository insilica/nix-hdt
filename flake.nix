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
        hdt-version = "1.3.3";
        hdt-cpp = stdenv.mkDerivation {
          pname = "hdt";
          version = hdt-version;

          src = fetchFromGitHub {
            owner = "rdfhdt";
            repo = "hdt-cpp";
            rev = "v${hdt-version}";
            sha256 = "1vsq80jnix6cy78ayag7v8ajyw7h8dqyad1q6xkf2hzz3skvr34z";
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
