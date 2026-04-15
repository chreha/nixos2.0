{ pkgs, ... }:
{
  users.users.charlie = {
    isNormalUser = true;
    description = "Charlie";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "docker"
      "libvirtd"
    ];
  };
}
