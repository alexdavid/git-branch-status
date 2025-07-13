{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # We keep a default bash shebang in the source script for anyone who is
        # using this outside of nix, but in this flake file we use
        # writeShellApplication which provides its own shebang.
        sourceWithoutShebang = with nixpkgs.lib; pipe ./git-branch-status [
          readFile
          (src: assert strings.hasPrefix "#!/usr/bin/env bash\n" src; src)
          (splitString "\n")
          tail
          (concatStringsSep "\n")
        ];
      in {
        packages.default = pkgs.writeShellApplication {
          name = "git-branch-status";
          text = sourceWithoutShebang;
        };
      }
    );
}
