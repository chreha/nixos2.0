# configuration for primary desktop system
{
  inputs,
  ...
}:
{
  imports = [
    inputs.self.userProfiles.charlie
    ./hardware-configuration.nix # unique to the primary desktop system
    inputs.self.nixosModules.common
    inputs.self.nixosModules.nvidia
  ];

  networking.hostName = "the-toad"; # unique to the primary desktop system

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
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
}
