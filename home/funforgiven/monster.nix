{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./global/features/desktop/awesome
  ];
}
