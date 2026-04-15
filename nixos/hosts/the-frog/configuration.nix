{
  config,
  ...
}:
{
  # description = "Configuration for laptop the-frog system";
  imports = [
    ../../users/charlie
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
  ];

  networking.hostName = "the-frog";
  system.stateVersion = "25.05";
  age.secrets.personal_key = {
    file = ../../../secrets/frog_personal.age; # Path to encrypted file in flake
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.personal";
    mode = "0600";
  };
  age.secrets.work_key = {
    file = ../../../secrets/frog_work.age; # Path to encrypted file in flake
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.work";
    mode = "0600";
  };
  # authorize for this host specifically
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
  ];
}
