{ inputs, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    packages = with pkgs; [
      dracula-theme
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
    firefox = {
      enable = true;
      profiles.charlie = {
        search.default = "ddg";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
        };
      };
    };
    plasma = {
      enable = true;
    };
    konsole = {
      enable = true;
      defaultProfile = "NixProfile";

      customColorSchemes = {
        Dracula = "${inputs.dracula-konsole}/Dracula.colorscheme";
      };
      profiles.NixProfile = {
        name = "NixProfile";
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 16; # Set your desired terminal font size here
        };
        colorScheme = "Dracula";
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
