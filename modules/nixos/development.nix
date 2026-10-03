{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  virtualisation.docker = {
    enable = true;
    package = unstable.docker;
  };

  virtualisation.oci-containers.backend = "docker";

  # Compatibility layer for unpatched binaries (VS Code, Node, etc.)
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Standard C++ library (required by almost everything)
      stdenv.cc.cc
      # Common network/security dependencies
      openssl
      curl
      # Compression utility
      zlib
    ];
  };
}
