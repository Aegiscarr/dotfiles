{
 pkgs, inputs, ...}: {

  home.packages = with pkgs; [
    # user packages
    firefox
    vscode
    blender
    vesktop
    steam
    gparted
    easyeffects
    gimp
    inkscape
    hyprpicker
#    obsidian
#    unityhub
#    audacity
  ];
}
