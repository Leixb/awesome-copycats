{
  description = "Cargo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        awesome = pkgs.awesome.override { lua = pkgs.lua5_3; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.sumneko-lua-language-server
            awesome
            pkgs.rofi
          ];
        };
      }
    );
}
