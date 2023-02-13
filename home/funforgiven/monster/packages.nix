{ lib, pkgs, ...}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      qbittorrent
      kate
      pavucontrol
      tdesktop
      ;
  };
}
