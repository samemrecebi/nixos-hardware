{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../common/cpu/amd
    ../../common/cpu/amd/zenpower.nix
    ../../common/cpu/amd/pstate.nix
    ../../common/gpu/amd
    ../../common/gpu/nvidia
    ../../common/gpu/nvidia/prime.nix
    ../../common/gpu/nvidia/ada-lovelace
    ../../common/pc/laptop
    ../../common/pc/laptop/ssd
    ../../common/hidpi.nix
  ];

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.6") pkgs.linuxPackages_latest;

  boot.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.amdgpu.initrd.enable = false;

  hardware.nvidia = {
    nvidiaSettings = lib.mkDefault true;
    modesetting.enable = lib.mkDefault true;
    powerManagement.enable = lib.mkDefault true;
    dynamicBoost.enable = lib.mkDefault true;
    prime = {
      amdgpuBusId = "PCI:54:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Seen better performance then PPD
  services.auto-cpufreq.enable = true;

  # Adds the missing asus functionality to Linux.
  # https://asus-linux.org/manual/asusctl-manual/
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
  };
}
