{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    settings.rejectDueToRemoteAccessDisabled = false;
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
