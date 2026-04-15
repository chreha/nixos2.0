{ ... }:
{
  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
    extraGroups = [
      "networkmanager"
    ];
  };
  # Wipe the guest home directory on every boot
  systemd.tmpfiles.rules = [
    "R /home/guest 0700 guest users -"
  ];
}
