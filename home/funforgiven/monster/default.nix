{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../global
    ./packages.nix
    ./firefox.nix
    ./discord.nix
    ./wezterm.nix
    ./steam.nix
    ./rofi.nix
    ./desktop.nix
    ./picom.nix
  ];

    xdg.mimeApps.enable = true;
}
