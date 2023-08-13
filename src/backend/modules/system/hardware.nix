{ config, lib, pkgs, modulesPath, ... }:

# TODO: Get the hardware config correct (I want to target Lenovo ThinkPads / ThinkCentres)

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

# Kernel
  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "vfio-pci" "coretemp" ];
  
# Bootloader
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      devices = [ "nodev" ];
      efiSupport = true;
      configurationLimit = 3;
    };

    efi = {
      canTouchEfiVariables = true;
    };
  };

# FStab
  fileSystems."/" =
    { device = "/dev/sda2";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/sda3";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
    };

# CPU
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

