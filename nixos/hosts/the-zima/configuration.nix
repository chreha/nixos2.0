{
  pkgs,
  config,
  ...
}:
{
  # description = "Configuration for zimaboard mini-pc server";
  imports = [
    ../../users/charlie
    ./hardware-configuration.nix
    ../../../modules/nixos/common-server.nix
    ../../../modules/nixos/filebrowser-server.nix
  ];

  networking.hostName = "the-zima";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Enable software RAID support
  boot.swraid.enable = true;

  # Ensure the kernel module is available during boot
  boot.initrd.availableKernelModules = [
    "md_mod"
    "raid1"
  ];

  fileSystems."/mnt/the-pond" = {
    device = "/dev/disk/by-uuid/853331de-1871-7955-c974-f02433ea4eca";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "compress=zstd"
    ];
  };

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
  # recognize the RAID members
  environment.systemPackages = with pkgs; [ mdadm ];

  system.stateVersion = "25.11";
}
