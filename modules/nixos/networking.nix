{
  pkgs,
  constants,
  config,
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

  age.secrets.nas-credentials = {
    file = ../../secrets/nas-credentials.age;
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
      "credentials=${config.age.secrets.nas-credentials.path}"

      # Permissions
      "uid=1000"
      "gid=100"
      "dir_mode=0755"
      "file_mode=0644"
    ];
  };
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
