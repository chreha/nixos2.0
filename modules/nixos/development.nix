{ pkgs, ... }:
{
  # Enable Docker daemon
  virtualisation.docker.enable = true;

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
