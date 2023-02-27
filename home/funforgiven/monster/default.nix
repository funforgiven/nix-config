{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../../funforgiven

    ./firefox.nix
    ./discord.nix
    ./kitty.nix
    ./gaming.nix
    ./dconf.nix
  ];

  home.packages = with pkgs; [
      transmission-gtk
      kate
      pavucontrol
      tdesktop
      gnome.gnome-tweaks
      gnome-themes-extra
      gtk-engine-murrine
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins=["git"];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Sky-Dark";
      package =  pkgs.catppuccin-gtk.override {
        accents = ["sky"];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 32;
    };
  };

#   qt = {
#     enable = true;
#     platformTheme = "gtk";
#   };
}
