 :{ 
  # enable programs
  programs = {
    git = {
      enable = true;
      userName = "Aegiscarr";
      userEmail = "itsmecobra2006@gmail.com";
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "";
        init.defaultBranch = "master";
    };
  };
