# configuration for primary desktop system
{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.self.userProfiles.charlie
    ./hardware-configuration.nix # unique to the primary desktop system
    inputs.self.nixosModules.common-server
    inputs.self.nixosModules.firebrowser-server
  ];

  networking.hostName = "the-zima"; # unique to the primary desktop system

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
    ]; # zstd is great for btrfs performance
  };

  # This allows NixOS to recognize the RAID members you found earlier
  environment.systemPackages = with pkgs; [ mdadm ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";

  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAdfqOg31FOaLYFtR00JalRK/j7HRcHAYkXR3t3tnKcF charlie@the-frog"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZTtndZISLL/CWmMauXvGvRDUXrRiwpMkmPuK5WzpV/ charlie@the-toad"
  ];

}
