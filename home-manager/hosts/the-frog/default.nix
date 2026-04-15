{ inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    # core + gui desktop
    ../../common/core.nix
    ../../common/desktop.nix
  ];
}
