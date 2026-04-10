{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # Feature modules
    inputs.self.nixosModules.system
    inputs.self.nixosModules.networking
    inputs.self.nixosModules.plasma-desktop
    inputs.self.nixosModules.development
    inputs.self.nixosModules.shell

    inputs.agenix.nixosModules.default
  ];

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
}
