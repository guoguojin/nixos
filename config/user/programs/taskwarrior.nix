{ config, pkgs, nixpkgs, ... }:

{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256";
    config = {
      search.case.sensitive = "no";
      taskd = {
        certificate = "/home/tanq/.ssh/intheam.certificate.pem";
        key = "/home/tanq/.ssh/intheam.key.pem";
        ca = "/home/tanq/.ssh/intheam.cert.pem";
        server = "inthe.am:53589";
        credentials = "inthe_am/guoguojin/88b65d2d-11b6-41e8-b9d5-f37da18ba4b6";
        trust = "strict";
      };
    };
  };
}