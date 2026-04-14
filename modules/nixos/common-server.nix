{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # Feature modules
    inputs.self.nixosModules.system
    inputs.self.nixosModules.shell

    inputs.agenix.nixosModules.default
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };
  # Global packages available on all hosts
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];

  # Enable networking via NetworkManager
  networking.networkmanager.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowPing = true;

    # Port 3389 is the standard for RDP (Remote Desktop)
    allowedTCPPorts = [ 3389 ];

    # Trust internal interfaces so services can talk to each other
    trustedInterfaces = [
      "docker0"
      "tailscale0"
    ];
  };

  # Tailscale configuration
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both"; # Allows host to act as exit node or subnet router
  };
}
