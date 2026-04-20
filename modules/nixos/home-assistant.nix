{ config, pkgs, ... }:
{

  # 1. Enable the Docker engine
  virtualisation.docker.enable = true;

  # 2. Define the Home Assistant Container
  virtualisation.oci-containers.containers.homeassistant = {
    image = "ghcr.io/home-assistant/home-assistant:stable";
    volumes = [
      "/mnt/the-pond/home-assistant:/config" # Stores your GUI settings/backups
      "/etc/localtime:/etc/localtime:ro"
    ];
    environment = {
      TZ = "${config.time.timeZone}";
    };
    extraOptions = [
      "--network=host" # Critical for discovering Wi-Fi devices
      "--privileged" # Helps with USB dongle access later
    ];
  };
  systemd.services."docker-homeassistant" = {
    requires = [ "mnt-the\x2dpond.mount" ];
    after = [ "mnt-the\x2dpond.mount" ];
  };
  # Tailscale sometimes triggers "RP Filter" blocks in Linux.
  # Setting this to loose ensures that traffic coming from your phone via Tailscale isn't dropped by the ZimaBoard's firewall.
  # Test without first, then enable if unable to connect via phone
  # networking.firewall.checkReversePath = "loose";
}
