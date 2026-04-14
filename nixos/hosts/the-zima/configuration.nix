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
    inputs.self.nixosModules.common
  ];

  networking.hostName = "the-zima"; # unique to the primary desktop system

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable software RAID support
  boot.swraid.enable = true;

  # Ensure the kernel module is available during boot
  boot.initrd.availableKernelModules = [
    "md_mod"
    "raid1"
  ];

  # This allows NixOS to recognize the RAID members you found earlier
  environment.systemPackages = with pkgs; [ mdadm ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
