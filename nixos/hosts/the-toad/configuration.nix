# configuration for primary desktop system
{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.self.userProfiles.charlie
    ./hardware-configuration.nix # unique to the primary desktop system
    inputs.self.nixosModules.common
    inputs.self.nixosModules.nvidia
  ];

  networking.hostName = "the-toad"; # unique to the primary desktop system

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
