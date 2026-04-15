{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default

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
