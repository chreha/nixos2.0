{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  boot.kernelModules = [ "sg" ]; # fix for makemkv not detecting cdrom

  environment.systemPackages = with pkgs; [
    # makemkv
    # handbrake
    # libbluray
    # vlc
    # cdparanoiaIII
  ];
}
