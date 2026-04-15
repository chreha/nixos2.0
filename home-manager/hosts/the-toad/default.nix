{ pkgs, ... }:
{
  imports = [
    # users
    ../../users/charlie
    ../../users/guest

    # core + gui desktop
    ../../common/core.nix
    ../../common/desktop.nix

    # feature sets
    ../../features/communication
    ../../features/developer
    ../../features/gaming
  ];
  home = {
    packages = with pkgs; [
      dracula-theme
      nixfmt-rfc-style
    ];
  };
}
