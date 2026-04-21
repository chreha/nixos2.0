{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    makemkv
    handbrake
    libbluray
    vlc
  ];
}
