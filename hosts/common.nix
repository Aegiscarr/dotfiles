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
    enable = false;
  };

  services.displayManager.sddm.enable = false;
  services.udisks2.enable = true;
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock.overrideAttrs (old: {
      version = "git";
      src = pkgs.fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprlock";
        rev = "2bce52f";
        sha256 = "36qa6MOhCBd39YPC0FgapwGRHZXjstw8BQuKdFzwQ4k=";
      };
      patchPhase = ''
        substituteInPlace src/core/hyprlock.cpp \
        --replace "5000" "16"
      '';
      });
  };
  

  hardware.graphics = {
    enable = true;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    bluez-alsa
    bluez
    mesa
    pavucontrol
    pulseaudio
    cinnamon.nemo
    dbus
    swaybg
    grim
    slurp
    wl-clipboard
    wofi
    hyfetch
    pkgs.liquidctl
    pkgs.ckb-next
    appimage-run
    playerctl
    cudaPackages.cudatoolkit
    swayidle
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

  # pkgcache
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://hyprland.cachix.org"
    "https://nixpkgs-wayland.cachix.org"
    "https://cache.garnix.io"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
      pkgs.mpv
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

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "aegiscarr";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = "true";
    TTYHangup = "true";
    TTYVTDisallocate = true;
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
