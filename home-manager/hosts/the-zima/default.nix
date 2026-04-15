{ config, inputs, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    # core + gui desktop
    ../../common/core.nix

    # feature sets

  ];
  age.secrets.personal_key = {
    file = ../../../secrets/toad_personal.age; # Path to encrypted file in flake
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.personal";
    mode = "0600";
  };
  age.secrets.work_key = {
    file = ../../../secrets/toad_work.age; # Path to encrypted file in flake
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.work";
    mode = "0600";
  };
}
