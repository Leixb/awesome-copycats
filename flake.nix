{
  description = "AwesomeWM master branch configutation with lain";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    awesome = {
      url = "github:awesomewm/awesome/master";
      flake = false;
    };

    lain = {
      url = "github:lcpz/lain/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, awesome, lain }:

  {
    overlay = final: prev: {
      awesome-config = self.packages.${prev.system}.awesome-config;
      awesome = self.packages.${prev.system}.awesome;
      lain = self.packages.${prev.system}.lain;
    };

  } // flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
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

        packages.lain = pkgs.lua53Packages.toLuaModule ( pkgs.stdenv.mkDerivation {
          name = "lain";
          src = lain;

          installPhase = ''
            mkdir -p $out/lib/lua/5.2/lain

            cp *.lua $out/lib/lua/5.2/lain/
            cp -r icons layout util widget $out/lib/lua/5.2/lain/
          '';
        });

        packages.awesome = (pkgs.awesome.overrideAttrs (oldAttrs: rec {
          src = awesome;
          patches = [];
        })).override {
          lua = pkgs.lua5_3;
          gtk3Support = true;
          gtk3 = pkgs.gtk3;
        };

        defaultPackage = self.packages.${system}.awesome-config;
      }
    );
}
