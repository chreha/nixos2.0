{
  pkgs,
  constants,
  config,
  lib,
  ...
}:
{
  # Enable networking via NetworkManager
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowPing = true;

    # Port 3389 is the standard for RDP (Remote Desktop)
    allowedTCPPorts = [
      3389
      22
      44443
    ];

    # Trust internal interfaces so services can talk to each other
    trustedInterfaces = [
      "docker0"
      "tailscale0"
    ];
  };

  # Tailscale configuration
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both"; # Allows host to act as exit node or subnet router
  };

  environment.systemPackages = [ pkgs.cifs-utils ];

  age.secrets.the-pond-samba-credentials = {
    file = ../../secrets/the-pond-samba-credentials.age;
    owner = "charlie";
    mode = "600";
  };
  fileSystems."/mnt/the-pond" = {
    device = constants.nasPath;
    fsType = "cifs";
    options = [
      # Crucial: Automount waits until you access the folder to connect
      "x-systemd.automount"
      "noauto" # Don't try to mount immediately at boot
      "x-systemd.idle-timeout=60" # Unmount after 60s of inactivity
      "x-systemd.mount-timeout=5s"
      "x-systemd.requires=network-online.target"
      "nofail"
      # Tailscale/Network helpers
      "_netdev"
      "x-systemd.after=tailscale.service" # Try to wait for tailscale

      # Credentials from agenix
      "credentials=${config.age.secrets.the-pond-samba-credentials.path}"

      # Permissions
      "uid=1000"
      "gid=100"
      "dir_mode=0755"
      "file_mode=0644"
    ];
  };
  security.pki.certificates = [
    (lib.strings.join "\n" [
      "-----BEGIN CERTIFICATE-----"
      "MIIBhjCCASygAwIBAgIRAKmyGOiNZfy5eiaNwFYfHvIwCgYIKoZIzj0EAwIwITEf"
      "MB0GA1UEAwwWQnJpYW4gfCBTdGVwQ0EgUm9vdCBDQTAeFw0yMjA4MDExNjUzNTJa"
      "Fw0zMjA4MDExNjUzNTJaMCExHzAdBgNVBAMMFkJyaWFuIHwgU3RlcENBIFJvb3Qg"
      "Q0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAQ+jbHULFNxsLl5Qzo+ka/p9rDe"
      "m7V6OdxDyJlM7iqyVJjD4B7QB/USclMjgrYatYd/VCNh92L+m6JJDw2qjQbTo0Uw"
      "QzAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQU"
      "HDp7nXzA1Y8IniEK7PpPESwoMWswCgYIKoZIzj0EAwIDSAAwRQIhAOmzD2vdOmme"
      "t16FHK/eBbphSd30ZDmaWHmbXlIDg/YJAiB1YCZ7vKQYI6n3wmaoJ/5vAlBlGePZ"
      "UeShRDyXOcJMkA=="
      "-----END CERTIFICATE-----"
    ])
  ];

  fileSystems."/mnt/the-toad-ark" = {
    device = "//the-toad/Ark";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "nofail"
      "_netdev"

      # Guest access settings
      "guest" # Tells cifs to connect without a password
      "uid=1000" # Files will look like they are owned by the laptop user
      "gid=100"
      "dir_mode=0777" # Full read/write/execute for the laptop user
      "file_mode=0666" # Full read/write for the laptop user
    ];
  };

}
