{
  pkgs,
  config,
  ...
}:
{
  # description = "Configuration for desktop the-toad system";
  imports = [
    ../../users/charlie
    ../../users/guest
    ../../../modules/nixos/fleet-ssh.nix
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
    ../../../modules/nixos/nvidia.nix
    ../../../modules/nixos/steam.nix
  ];

  networking.hostName = "the-toad";
  system.stateVersion = "25.05";

  fileSystems."/mnt/Ark" = {
    device = "/dev/disk/by-uuid/1ED0FEBCD0FE996B";
    fsType = "ntfs3";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "uid=1000"
      "gid=100"
      "umask=0022"
    ];
  };
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "the-toad";
        "netbios name" = "the-toad";
        "security" = "user";
        # Restrict access to your local/Tailscale network
        "hosts allow" = "100. 192.168. 127.0.0.1";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "Ark" = {
        "path" = "/mnt/Ark";
        "browsable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "public" = "yes";
        "force user" = "charlie";
        "create mask" = "0666";
        "directory mask" = "0777";
      };
    };
  };
  # authorize for this host specifically
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
  ];
}
