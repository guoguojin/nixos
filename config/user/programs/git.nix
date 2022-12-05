{ config, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        editor = "vim";
      };
      url = {
        "git@github.com:vegaprotocol" = { 
          insteadOf = "https://github.com/vegaprotocol";
        };
      };
      "gitflow \"prefix\"" = {
        versiontag = "v";
      };
      "gitflow \"branch\"" = {
        master = "main";
        develop = "develop";
      };
      init = {
        defaultBranch = "main";
      };
    };
    signing = {
      key = "4352FFFC";
      signByDefault = true;
    };
    userEmail = "t@nqua.ch";
    userName = "Tan Quach";
  };
}