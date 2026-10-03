{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # Feature modules
    ./shell.nix
    ./system.nix
    ./networking.nix

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
  environment.variables.EDITOR = "nano";

  boot.supportedFilesystems = [ "cifs" ];

  # Global packages available on all hosts
  environment.systemPackages = with pkgs; [
    vim
    git
    dig
    traceroute
    curl
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Enable CUPS to print documents
  services.printing = {
    enable = true;
    drivers = [
      pkgs.brlaser # Open-source driver for Brother laser printers
      pkgs.cups-filters
      pkgs.cups-browsed
    ];
  };

  # Enable Avahi for network printer discovery (.local / mDNS)
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Resolve IPv4 mDNS hostnames
    openFirewall = true; # Open UDP port 5353 for discovery
  };

}
