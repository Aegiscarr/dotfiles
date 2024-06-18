_: {
  # enable programs
  programs = {
    git = {
      enable = true;
      userName = "Aegiscarr";
      userEmail = "itsmecobra2006@gmail.com";
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        init.defaultBranch = "master";
      };
    };
    # ... add more programs as you see fit
  };
}
