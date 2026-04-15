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
  ];

  networking.hostName = "the-frog";
  system.stateVersion = "25.05";

  # This allows members of the 'keys' group to read the host key
  services.openssh.hostKeys = [
    {
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];

  # Ensure the group permissions are applied
  systemd.services.ssh-keys-permissions = {
    description = "Set permissions for SSH host keys";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/chmod 640 /etc/ssh/ssh_host_ed25519_key";
    };
  };
  systemd.tmpfiles.rules = [
    "z /etc/ssh/ssh_host_ed25519_key 0640 root keys -"
  ];
  # authorize for this host specifically
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
  ];
}
