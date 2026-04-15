{ config, inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    # core + gui desktop
    ../../common/core.nix

    # feature sets

  ];
}
