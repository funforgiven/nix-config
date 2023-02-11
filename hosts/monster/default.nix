{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../common/global
    ../common/users/funforgiven

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "monster";
    networkmanager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  }; 

  environment = {
    systemPackages = lib.attrValues{
        inherit
        (pkgs)
        libva
        libva-utils
        ocl-icd
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
        ;
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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

  system.stateVersion = "23.05";
}
