{
  pkgs,
  config,
  ...
}:
{
  # description = "Configuration for laptop the-frog system";
  imports = [
    ../../users/charlie
    ../../users/guest
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
    ../../secrets
  ];

  networking.hostName = "the-frog";
  system.stateVersion = "25.05";

  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC7uluRYzR8q758nMYwSJKriYPsfGziXIdLSDj/HSCrA charlie"
  ];
}
