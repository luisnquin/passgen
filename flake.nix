{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        defaultPackage = pkgs.buildGoModule {
          pname = "passgen";
          version = "latest";
          src = builtins.path {
            name = "passgen-src";
            path = ./.;
          };

          buildTarget = ".";

          vendorHash = null;
          doCheck = true;
        };
      in {
        inherit defaultPackage;

        defaultApp = flake-utils.lib.mkApp {
          drv = defaultPackage;
        };

        devShell = pkgs.mkShell {
          buildInputs = [defaultPackage];
        };
      }
    );
}
