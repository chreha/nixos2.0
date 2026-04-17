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

  # Global packages available on all hosts
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];
}
