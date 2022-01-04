{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            sumneko-lua-language-server
          ];
        };

        packages.awesome-config = pkgs.stdenv.mkDerivation {
          name = "awesome-config";
          src = ./.;

          installPhase = ''
            mkdir -p $out
            cp rc.lua $out
            cp -r themes $out
          '';
        };

        defaultPackage = self.packages.${system}.awesome-config;
      }
    );
}
