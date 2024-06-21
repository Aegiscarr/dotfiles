{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # this is where we import other files from our config, we import our fstab and common files.
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  programs = {
    # systemwide programs can be added here
  };

  environment.systemPackages = with pkgs; [
    # systemwide packages can be added here
  ];

  networking.hostName = "SERRATA-NIX";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/";
  
  # audio maybe
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # cuda support
  boot.kernelModules = [ "nvidia-uvm" ];
  hardware.xone.enable = true;

  # enable networking
  networking.networkmanager.wifi.backend = "iwd";

  # nvidia drivers
  services.xserver.videoDrivers=["nvidia"];

  # autologin
  #services.getty.autologinUser = "aegiscarr";

  hardware.nvidia = {
    modesetting.enable=true;
    nvidiaPersistenced=true;
    powerManagement.enable=true;
    open=false;
    nvidiaSettings=true;
    package=config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # opengl/vulkan support
  hardware.graphics = {
    driSupport32Bit=true;
    extraPackages=with pkgs; [
      amdvlk
      libvdpau-va-gl
      mesa
      nvidia-vaapi-driver
      vaapiVdpau
      vulkan-validation-layers
      rocmPackages.clr.icd
    ];
   extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
      driversi686Linux.mesa
      pkgsi686Linux.nvidia-vaapi-driver
    ];
  };

  boot.supportedFilesystems = [ "btrfs" "ntfs" ];

  # Set a time zone
  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # TODO: change the username to your actual username
  users.users.aegiscarr = {
    isNormalUser = true;
    description = "Silvally"; # this is the friendly name you will see in displayManagers and desktop environmnnts,
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
  };

  # enable ssh if wanted
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };
}
