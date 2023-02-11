{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
    };
    layout = "tr";
    videoDrivers = ["nvidia"];
    windowManager = {
      awesome = {
        enable = true;
      };
    };
  };
}
