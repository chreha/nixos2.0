{ ... }:
{
  # Enable the X11 windowing system.
  # (Required for SDDM and certain Xwayland applications)
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # SDDM can sometimes have issues with high-DPI screens (like laptops)
  # If 'the-frog' has a tiny 4k screen, we might add scaling here later.
  services.displayManager.sddm.wayland.enable = true;
}
