{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../common/cpu/amd
    ../../common/cpu/amd/raphael/igpu.nix
    ../../common/cpu/amd/pstate.nix
    ../../common/gpu/nvidia
    ../../common/gpu/nvidia/prime.nix
    ../../common/hidpi.nix
    ../../common/pc/laptop
    ../../common/pc/ssd
    ../battery.nix
  ];

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.6") pkgs.linuxPackages_latest;

  boot = {
    kernelModules = ["kvm-amd"];
    kernelParams = [
      "mem_sleep_default=deep"
      "pcie_aspm.policy=powersupersave"
      "amdgpu.gpu_recovery=1"
      "amdgpu.sg_display=0"
      "amdgpu.dcdebugmask=0x10"
    ];
  };

  # Adds the missing asus functionality to Linux.
  # https://asus-linux.org/manual/asusctl-manual/
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
  };

  boot = {
    blacklistedKernelModules = ["nouveau"];
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;
    nvidiaSettings = lib.mkDefault true;
    prime = {
      offload = {
        enable = lib.mkDefault true;
        enableOffloadCmd = lib.mkDefault true;
      };
      amdgpuBusId = "PCI:54:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
