{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/global
    ../common/users/funforgiven

    ./hardware-configuration.nix
  ];

  networking.hostName = "monster";

  boot = {

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["btrfs"];
    };

    kernelModules = ["acpi_call"];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  }; 

  environment = {
    systemPackages = lib.attrValues{
        inherit
        (pkgs)
        acpi
        arandr
        blueberry
        brightnessctl
        libva
        libva-utils
        ocl-icd
        slop
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
        ;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        reverseSync.enable = true;
      };
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = lib.attrValues {
        inherit
          (pkgs)
          intel-media-driver
          libvdpau-va-gl
          vaapiIntel
          vaapiVdpau
          nvidia-vaapi-driver
          ;
      };
    };
  };

  services = {
    acpid.enable = true;
    blueman.enable = true;
    thermald.enable = true;
    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0; # dummy value
        STOP_CHARGE_THRESH_BAT0 = 1; # battery conservation mode
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
      };
      layout = "tr";
      videoDrivers = ["nvidia"];
      windowManager = {
        awesome = {
          enable = true;

          luaModules = lib.attrValues {
            inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };
  };


  system.stateVersion = "23.05";
}
