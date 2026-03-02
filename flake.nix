{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs:
        let
        lib = inputs.snowfall-lib.mkLib {
            inherit inputs;

            src = ./.;

            snowfall = {
                namespace = "caprinix";

                meta = {
                    name = "caprinix-snowfall-lib-starter";
                    title = "Caprinix - snowfall-lib-starter";
                };
            };
        };
        in lib.mkFlake {
          outputs-builder = channels: let
            treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
          in {
            formatter = treefmtEval.config.build.wrapper;
          };
        };
}
