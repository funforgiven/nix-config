{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../../funforgiven

    ./packages.nix
    ./firefox.nix
    ./discord.nix
    ./wezterm.nix
    ./gaming.nix
    ./rofi.nix
  ];

  xdg.mimeApps.enable = true;
}
