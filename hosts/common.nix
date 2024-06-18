# this file allows for easy host addition as it adds the most basic common
# features of your nixos configuration
{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.udisks2.enable = true;
# services.desktopManager.plasma6.enable = true;
#  services.xserver = {
#    displayManager.lightdm.enable = true;
#    desktopManager.xfce.enable = true;
#  };

  # hyprland launch under sddm

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    bluez-alsa
    bluez
    mesa
    pavucontrol
    pulseaudio
    xfce.thunar
    dbus
    swaybg
    grim
    slurp
    wl-clipboard
    wofi
    hyfetch
    pkgs.liquidctl
    pkgs.ckb-next
  ];

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
    oxygenfonts
    config.nur.repos.ilya-fedin.exo2
  ];

  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif" "Source Han Serif"];
    sansSerif = ["Noto Sans" "Source Han Sans"];
  };

  hardware.bluetooth.enable = true;

  services.acpid.enable = true;
  services.blueman.enable = true;
  services.dbus.enable = true;
  services.lvm.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.drivers = [ pkgs.gutenprint ];

  console.useXkbConfig = true;

  networking.networkmanager.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;

  system.stateVersion = "24.05";
}
