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
    ../../secrets
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

  # recognize the RAID members
  environment.systemPackages = with pkgs; [ mdadm ];

  system.stateVersion = "25.11";
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJkH8jsaaU4V0/+KETE1oTzgilMFq9Ka494e+xdZYAP github-personal@the-toad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyWgDz2yH+tyu6Z7e+/kVtbY4iW8aNJte6y8wwlaUjR github-personal@the-frog"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2ssoOZXTvcF355EWkYK0I3NLfPUU0F+ciLPKb3So0V github-personal@the-zima"
  ];
}
