{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/desktop/awesome
    ./features/games
  ];
}
