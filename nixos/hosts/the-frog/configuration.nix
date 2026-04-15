{
  ...
}:
{
  description = "Configuration for laptop the-frog system";
  imports = [
    ../../users/charlie
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
  ];

  networking.hostName = "the-frog";
  system.stateVersion = "25.05";
}
