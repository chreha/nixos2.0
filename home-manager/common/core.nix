{ ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  home.file.".ssh/authorized_keys".text = ''
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjJ1tbdDkzyL/GSbsRHyWoy9ucRnl8hv11qDnId6Ddd charlie@the-frog"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJwvq1/i4Ca2POsNFNdep+bs6AKJovBGZl5sJbCJ68m charlie@the-toad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFXF/Rop5pefdJJSnzH2ttb9e9Hj995R+IpCpayFa8iM charlie@the-zima"
  '';
}
