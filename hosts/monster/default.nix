{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../common/users/funforgiven

    ./hardware-configuration.nix
  ];

  networking.hostName = "monster";

  boot = {
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
        libva
        libva-utils
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
        ocl-icd
        ;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;

    nvidia = {
      modesetting.enable = true;

      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
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

  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
    desktopManager = {
      plasma5.enable = true;
    };
    layout = "tr";
    videoDrivers = ["nvidia"];
  };

  services.logind = {
    lidSwitch = "lock";
  };

  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
  };

  system.stateVersion = "23.05";
}
