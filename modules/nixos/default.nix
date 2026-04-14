# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  common = import ./common.nix;
  common-server = import ./common-server.nix;
  firebrowser-server = import ./filebrowser-server.nix;
  development = import ./development.nix;
  plasma-desktop = import ./plasma-desktop.nix;
  networking = import ./networking.nix;
  nvidia = import ./nvidia.nix;
  system = import ./system.nix;
  shell = import ./shell.nix;
  steam = import ./steam.nix;
}
