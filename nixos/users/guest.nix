{ pkgs, ... }:
{
  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };
}
