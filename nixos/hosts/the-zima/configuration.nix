# configuration for primary desktop system
{
  inputs,
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
