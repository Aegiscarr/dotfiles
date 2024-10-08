{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix # home.packages and similar stuff
    ./programs.nix # programs.<programName>.enable
    ./git.nix
  ];

  home = {
    # TODO - change username
    username = "aegiscarr";
    homeDirectory = "/home/aegiscarr";
    #file.".config/foot/foot.ini".source = ./configs/foot.ini;
    #file.".config/hypr/hyprlock.conf".source = ./configs/hyprlock.conf;
    pointerCursor = {
      gtk.enable=true;
      name = "Posy's Cursor";
      package = pkgs.stdenvNoCC.mkDerivation {
        name = "posy-improved-cursor";

        src = pkgs.fetchFromGitHub {
          owner = "simtrami";
          repo = "posy-improved-cursor-linux";
          rev = "bd2bac08bf01e25846a6643dd30e2acffa9517d4";
          hash = "sha256-ndxz0KEU18ZKbPK2vTtEWUkOB/KqA362ipJMjVEgzYQ=";
        };

        dontBuild = true;

        installPhase = ''
          mkdir -p $out/share/icons
          mv Posy_Cursor "$out/share/icons/Posy's Cursor"
        '';
      };
      size = 16;
      x11.enable = true;
    };

  };
  
  gtk.cursorTheme.name = "Posy's Cursor";
  qt.enable = true;
  qt.platformTheme.name = "gtk";

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  programs.bash.shellAliases = {
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";
    rebuild = "nixos-rebuild switch --flake .#SERRATA-NIX --use-remote-sudo";
  };

  # Nicely reload system(d) units when changing configs
  systemd.user.startServices = lib.mkDefault "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";

  services.arrpc.enable = true;
  services.udiskie.enable = true;
}
