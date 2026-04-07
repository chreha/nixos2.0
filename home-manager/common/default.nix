{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Common programs every user should have
  programs.home-manager.enable = true;
  packages = with pkgs; [
    google-chrome
    slack
    discord
  ];

  firefox = {
    enable = true;
    profiles.charlie = {
      search.default = "ddg";
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
