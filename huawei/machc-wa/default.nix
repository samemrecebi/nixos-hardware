{lib, ...}: {
  imports = [
    ../../common/cpu/intel/comet-lake
    ../../common/gpu/intel
    ../../common/gpu/intel/comet-lake
    ../../common/gpu/nvidia
    ../../common/gpu/nvidia/pascal
    ../../common/gpu/nvidia/prime.nix
    ../../common/hidpi.nix
    ../../common/pc/laptop
    ../../common/pc/laptop/ssd
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    nvidiaSettings = lib.mkDefault true;
    modesetting.enable = lib.mkDefault true;
    powerManagement.enable = lib.mkDefault false;
    dynamicBoost.enable = lib.mkDefault false;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.auto-cpufreq.enable = true;
}
