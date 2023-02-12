{pkgs, ...}: {
  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    logind = {
      lidSwitch = "ignore";
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    udev.packages = [pkgs.gnome.gnome-settings-daemon];

    fstrim.enable = true;
    fwupd.enable = true;
    geoclue2.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse = {
      path = [pkgs.pulseaudio];
      wantedBy = ["default.target"];
    };
  };
}
