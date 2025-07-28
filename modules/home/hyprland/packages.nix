{pkgs, ...}: {

  # Extra packages not declared by a module

  home.packages = with pkgs; [
    # Screenshot & recording
    hyprshot # Advanced screenshot tool
    grimblast # Backup screenshot tool
    grim # Basic screenshot
    slurp # Region selector
    tesseract # OCR
    satty # Screenshot annotation tool
    swappy # Screenshot editor
    wf-recorder # Screen recording

    # Clipboard & color
    cliphist # Clipboard history
    wl-clipboard # Clipboard utilities
    hyprpicker # Color picker

    # Wallpaper & display
    wpaperd # Wallpaper daemon
    brightnessctl # Brightness control
    hyprsunset # blue-light filter

    # Lock & idle
    hypridle # Idle daemon
    hyprlock # Lock screen

    # Session
    wlogout # Power menu

    # Authentication
    hyprpolkitagent

    # Fonts and cursors
    hyprcursor

    # Utilities
    hyprutils
  ];
}
