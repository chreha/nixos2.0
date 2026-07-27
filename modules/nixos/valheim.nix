{
  ...
}:
{
  systemd.tmpfiles.rules = [
    "d /etc/valheim/config 0755 root root -"
    "d /etc/valheim/data 0755 root root -"
  ];

  virtualisation.oci-containers.containers.valheim = {
    image = "lloesche/valheim-server";

    extraOptions = [
      "--cap-add=sys_nice"
      "--stop-timeout 120"
    ];

    autoStart = true;

    volumes = [
      "/etc/valheim/config:/config"
      "/etc/valheim/data:/opt/valheim"
    ];

    ports = [
      "2456:2456/udp"
      "2457:2457/udp"
    ];

    environment = {
      SERVER_NAME = "ValheimOnTheZima";
      WORLD_NAME = "FinalRealm";
      SERVER_PASS = "Tailscale";
    };
  };
}
