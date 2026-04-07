{ inputs, pkgs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Common programs every user should have
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    # You can put your shared git settings here!
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
