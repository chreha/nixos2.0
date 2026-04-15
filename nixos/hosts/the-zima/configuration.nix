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

  age.secrets.personal_key = {
    file = ../../../secrets/toad_personal.age; # Path to encrypted file in flake
    path = "/home/charlie/.ssh/id_ed25519.personal";
    mode = "0600";
    owner = "charlie";
  };
  age.secrets.work_key = {
    file = ../../../secrets/toad_work.age; # Path to encrypted file in flake
    path = "/home/charlie/.ssh/id_ed25519.work";
    mode = "0600";
    owner = "charlie";
  };
  # recognize the RAID members
  environment.systemPackages = with pkgs; [ mdadm ];

  system.stateVersion = "25.11";
}
