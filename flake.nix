{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          mdbook-latest = pkgs.mdbook.overrideAttrs (old: rec {
            version = "0.5.3";
            src = pkgs.fetchFromGitHub {
              owner = "rust-lang";
              repo = "mdBook";
              rev = "v${version}";
              hash = "sha256-RMJQn58hshBGQSpu30NdUOb3Prywn6NfhauSzFZ35xQ=";
            };
            cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
              inherit src;
              hash = "sha256-LlImOjTQjMQURQ81Gn73v+DEHXqyyiz39K9T+MrE7S0=";
            };
          });
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [
              mdbook-latest
            ];
          };
        };
      flake = {
      };
    };
}
