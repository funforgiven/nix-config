{ lib, ... }:
{
  services.tailscale.enable = true;

  networking.nameservers = [ "100.100.100.100" "1.1.1.1" ];
  networking.search = [ "tail47254.ts.net" ];
}
