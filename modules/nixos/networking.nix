{
  pkgs,
  constants,
  config,
  ...
}:
{

  age.secrets.nas-credentials = {
    file = ../../secrets/nas-credentials.age;
    owner = "root";
    group = "root";
    mode = "600";
  };

  # Enable networking via NetworkManager
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowPing = true;

    # Port 3389 is the standard for RDP (Remote Desktop)
    allowedTCPPorts = [ 3389 ];

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
      "credentials=${config.age.secrets.nas-credentials.path}"

      # Permissions
      "uid=1000"
      "gid=100"
      "dir_mode=0755"
      "file_mode=0644"
    ];
  };
}
