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
    ../../../modules/nixos/fleet-ssh.nix
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
  ];

  networking.hostName = "the-frog";
  system.stateVersion = "25.05";

  # authorize for this host specifically
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIhxHRXd13qb+xkHCnovEEL8rT93BYhTQCW6F3uRy9J8 charlie.personal@the-toad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
  ];
}
