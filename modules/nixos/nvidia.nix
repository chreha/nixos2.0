{
  config,
  lib,
  pkgs,
  ...
}:

{
  # 1. Enable Hardware Graphics (Renamed from hardware.opengl in newer NixOS)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Often needed for Steam/Wine
  };

  # 2. Load the driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # 3. Nvidia Specific Settings
  hardware.nvidia = {
    modesetting.enable = true;

    # Required for 10-series (Pascal) GPUs
    open = false;

    # 1080 Ti doesn't support the newest fine-grained power management
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    nvidiaSettings = true;

    # Recommendation: Use 'stable' unless you specifically need an old version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 4. Kernel parameters for better Wayland/Sleep support
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
