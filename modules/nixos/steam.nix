{ ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

  };

  # enable by adding this to the steam launch options
  # gamemoderun %command%
  # Reducing stutter and maximizing frame rates, especially on laptops or systems with aggressive power-saving settings.
  programs.gamemode.enable = true;
  # enable by adding this to the steam launch options
  # gamescope -- %command%
  # Handheld devices, high-resolution monitors where you need upscaling, or games with buggy window management.
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;
  programs.gamescope.args = [
    "--fullscreen"
    "--nested-refresh 60"
    "--nested-width 1920"
    "--nested-height 1080"
  ];
}
