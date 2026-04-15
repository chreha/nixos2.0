{ ... }:
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
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIWc0PwJEhUp9iP475J94WohR3c1/8fp/B7AXs99lduc brian@two"
    ];
  };
}
