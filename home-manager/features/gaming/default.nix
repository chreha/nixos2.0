{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      protonup-ng
      protonup-qt
    ];
    file.".steam/root/steamapps/common/ark-games".source =
      config.lib.file.mkOutOfStoreSymlink "/mnt/the-toad-ark/SteamLibrary/steamapps/common";
  };
}
