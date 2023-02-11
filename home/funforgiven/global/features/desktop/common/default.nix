{ pkgs, lib, outputs, ... }:
{
  imports = [
    #./font.nix
    #./gtk.nix
    ./qt.nix

    ./discord.nix
    ./firefox.nix
    ./wezterm.nix
    ./pavucontrol.nix
  ];

  xdg.mimeApps.enable = true;
}
