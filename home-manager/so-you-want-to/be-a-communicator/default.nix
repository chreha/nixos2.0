{ inputs, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      slack
      discord
    ];
  };
  programs = {
    thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "privacy.donottrackheader.enabled" = true;
        };
      };
    };
  };
}
