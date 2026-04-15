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
}
