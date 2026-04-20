{ config, pkgs, ... }:

{
  # Enable the Tailscale daemon
  services.tailscale.enable = true;

  services.vaultwarden = {
    enable = true;
    config = {
      # Use your Tailscale MagicDNS name as the domain
      DOMAIN = "https://the-zima";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };

  # Optional: Allow the Tailscale interface in the firewall
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
