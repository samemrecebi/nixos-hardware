{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../common/cpu/intel
    ../../common/cpu/intel/comet-lake
    ../../common/gpu/nvidia/disable.nix
    ../../common/hidpi.nix
    ../../common/pc/laptop
    ../../common/pc/ssd
  ];

  # AMD has better battery life with PPD over TLP:
  # https://community.frame.work/t/responded-amd-7040-sleep-states/38101/13
  services.power-profiles-daemon.enable = lib.mkDefault true;
}
