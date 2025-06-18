{
  description = "POC ARM AArch32 Bootloader";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShell = pkgs.mkShell {
          name = "arm-bootloader-shell";
          buildInputs = [
            pkgs.qemu           # For emulating ARM
            pkgs.arm-none-eabi-gcc
            pkgs.arm-none-eabi-binutils
            pkgs.gnumake        # If you use Makefile
          ];

          shellHook = ''
            echo "📦 ARM Dev Environment Ready (AArch32 Bare-Metal)"
          '';
        };
      }
    );
}
