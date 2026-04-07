{ pkgs, ... }:
{
  user.users.charlie = {
    isNormalUser = true;
    description = "General System User - Charlie";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "docker"
      "libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
  };
}
