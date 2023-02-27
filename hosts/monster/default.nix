{ inputs, outputs, lib, config, pkgs, ... }:
let
  prime-run = pkgs.writeShellScriptBin "prime-run" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
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

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
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
        glxinfo
        ;
    } ++ [ prime-run ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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

  services = {
    gnome.core-utilities.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
    };
    desktopManager = {
      gnome.enable = true;
    };
    layout = "us";
    videoDrivers = [ "nvidia" ];
  };

  services.logind = {
    lidSwitch = "lock";
  };

  hardware.pulseaudio.enable = false;
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
