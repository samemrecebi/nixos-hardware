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
    ../../common/pc/laptop
    ../../common/pc/ssd
  ];

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.6") pkgs.linuxPackages_latest;

  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  services.power-profiles-daemon.enable = lib.mkDefault true;

  # Adds the missing asus functionality to Linux.
  # https://asus-linux.org/manual/asusctl-manual/
  services = {
    asusd = {
      enable = lib.mkDefault true;
      enableUserService = lib.mkDefault true;
    };
  };

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;
    open = lib.mkDefault true;
    nvidiaSettings = lib.mkDefault true;
    prime = {
      amdgpuBusId = "PCI:54:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
