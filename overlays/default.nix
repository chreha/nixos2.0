# This file defines overlays
{ inputs, ... }:
{

  # This adds community-maintained flake for VS Code extensions referenced with with pkgs.vscode-marketplace;
  # The official versions of this flake are referenced using pkgs.vscode-extensions
  # but this official channel has a more limited offering of extensions. use official if available, otherwise
  # use the community-maintained one
  vscode-extensions = inputs.nix-vscode-extensions.overlays.default;

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
