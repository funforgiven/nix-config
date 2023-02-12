{ inputs, lib, pkgs, config, outputs, ... }: let inherit (inputs.nix-colors) colorSchemes;
in {
  imports =
    [
      inputs.nix-colors.homeManagerModule
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = "funforgiven";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
  };

  colorscheme = colorSchemes.ashes;
  home.file.".colorscheme".text = config.colorscheme.slug;
}

