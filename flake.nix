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
        hdt-version = "d9ae092bb37d9fe85558dfb3edfe0bb6ddddf41a";
        hdt-cpp = stdenv.mkDerivation {
          pname = "hdt";
          version = hdt-version;

          src = fetchFromGitHub {
            owner = "rdfhdt";
            repo = "hdt-cpp";
            rev = "${hdt-version}";
            sha256 = "sha256-n9bTZq2BXWpZ9mKsANTO2QXzED/AG4HGxGG1p5HdtE4=";
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
