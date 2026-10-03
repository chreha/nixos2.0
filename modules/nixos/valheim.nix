{
  ...
}:
{
  systemd.tmpfiles.rules = [
    "d /etc/valheim/config 0755 root root -"
    "d /etc/valheim/data 0755 root root -"
    "d /etc/valheim/backups 0755 root root -"
  ];

  virtualisation.oci-containers.containers.valheim = {
    image = "lloesche/valheim-server:latest";

    extraOptions = [
      "--cap-add=sys_nice"
    ];

    autoStart = true;

    volumes = [
      "/etc/valheim/config:/config"
      "/etc/valheim/data:/opt/valheim"
      "/etc/valheim/backups:/backups"
    ];

    ports = [
      "2456:2456/udp"
      "2457:2457/udp"
    ];

    environment = {
      SERVER_NAME = "ValheimOnTheZima";
      WORLD_NAME = "FinalRealm";
      SERVER_PASS = "Tailscale";
      SERVER_PUBLIC = "false";

      UPDATE_ON_STARTUP = "true";
      UPDATE_INTERVAL = "86400"; # 24 hours

      BEPINEX = "true";
    };
  };
}
