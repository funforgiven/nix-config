{ pkgs, lib, outputs, ... }: {
  imports = [
    #./font.nix
    #./gtk.nix
    ./qt.nix

    ./firefox.nix
    ./discord.nix
    ./telegram.nix
    ./qbittorrent.nix
    ./wezterm.nix
    ./kate.nix
    ./dolphin.nix
    ./rofi.nix
    ./pavucontrol.nix
  ];

  xdg.mimeApps.enable = true;
}
