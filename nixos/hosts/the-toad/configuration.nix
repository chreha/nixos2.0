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
    ./hardware-configuration.nix
    ../../../modules/nixos/common.nix
    ../../../modules/nixos/plasma-desktop.nix
    ../../../modules/nixos/development.nix
    ../../../modules/nixos/nvidia.nix
    ../../../modules/nixos/steam.nix
    ../../secrets
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
  users.users.charlie.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJkH8jsaaU4V0/+KETE1oTzgilMFq9Ka494e+xdZYAP github-personal@the-toad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILyWgDz2yH+tyu6Z7e+/kVtbY4iW8aNJte6y8wwlaUjR github-personal@the-frog"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2ssoOZXTvcF355EWkYK0I3NLfPUU0F+ciLPKb3So0V github-personal@the-zima"
  ];
}
