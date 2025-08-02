{pkgs, ...}: {
  # Extra packages not declared by a module
  home.packages = with pkgs; [
    # Screenshot & recording
    hyprshot # Advanced screenshot tool
    slurp # Region selector
    tesseract # OCR - image text to system text
    satty # Screenshot annotation tool
    swappy # Screenshot editor
    wf-recorder # Screen recording

    # Clipboard & color
    cliphist # Clipboard history
    wl-clipboard # Clipboard utilities
    hyprpicker # Color picker

    # Wallpaper & display
    hyprpaper # Wallpaper daemon
    brightnessctl # Brightness control
    hyprsunset # blue-light filter

    # Session
    wlogout # Power menu

    # Fonts and cursors
    hyprcursor

    # Utilities
    hyprutils
    hyprsysteminfo
    hyprgraphics
    hyprland-qtutils
  ];
}
