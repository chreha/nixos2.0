# configuration for primary desktop system
{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix # unique to the primary desktop system
    ./nvidia.nix # unique to the 1080TI graphics card used in the primary desktop system
    (inputs.self + /nixos/common.nix) # shared system and user configuration settings
  ];

  networking.hostName = "the-toad"; # unique to the primary desktop system

  # In /etc/nixos/configuration.nix
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add common libraries extensions often need
    stdenv.cc.cc
    openssl
    curl
    zlib
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
