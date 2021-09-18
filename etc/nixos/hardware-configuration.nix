# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "usb_storage" "ums_realtek" "sd_mod" "sr_mod" ];
  # configure proprietary drivers
  nixpkgs.config.allowUnfree = true;
  boot.initrd.kernelModules = [ "wl" ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # GPU drivers
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a5d6e912-273b-4087-b633-2332a44b6a57";
      fsType = "ext4";
    };

  # for storage devices
  # Enable NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  # fileSystems."/mnt/Storage" =
  #   { device = "/dev/disk/by-uuid/B901-794A";
  #     fsType = "vfat";
  #     options = [ "defaults" "injamul" "rw" "utf8" "noauto" "umask=000" ];
  #   };

  swapDevices = [ ];

  # virtualisation.virtualbox.guest.enable = true; # disable as it is not in virtualbox
}
