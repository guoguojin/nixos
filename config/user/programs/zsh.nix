{ config, pkgs, nixpkgs, ... }:

{
  programs = {
    # Configure Zsh
    # Full list of options available at https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };

      initExtra = ''
      # Source powerlevel10k
      [[ -f ${config.xdg.configHome}/zsh/.p10k.zsh ]] && source ${config.xdg.configHome}/zsh/.p10k.zsh
      [[ -f ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme ]] && source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';

      envExtra = ''
        GOPATH=$HOME/go
        PATH=$PATH:$GOPATH/bin
        GOPRIVATE=gitlab.com/alphaquants,gitlab.com/bl-go,gitlab.com/bl-alhambra,gitlab.com/bl-oakenfield,gitlab.com/bl-paladin,gitlab.com/birchwoodlangham,gitlab.com/gobl
        DOCKER_BUILDKIT=1
        XZ_OPT="-T0"
      '';

      shellAliases = {
        ll = "ls -la";
        ls = "ls --color=auto";
        la = "ls -a";

        psgrep = "ps aux | grep -v grep | grep -i -e VSZ -e";

        ## Colorize the grep command output for ease of use (good for log files)##
        grep = "grep --color=auto";
        egrep = "egrep --color=auto";
        fgrep = "fgrep --color=auto";

        df = "df -h";
        jctl = "journalctl -p 3 -xb";

        reap = "mosh tanq@reaper.birchwoodlangham.com -- /home/tanq/bin/tm";
        hellcat = "mosh tanq@hellcat.birchwoodlangham.com -- /home/tanq/bin/tm";
        lps = "lpass ls | grep -i";
        lpu = "lpass show -c --user";
        lpp = "lpass show -c --password";
        lpshow = "lpass show";
        lpnotes = "lpass show -c --notes";
        rebuild-fonts = "sudo fc-cache -f";
        mkdocx = "pandoc --reference-doc /home/tanq/pandoc/SRL_Empty_Document.dotx --filter /home/tanq/pandoc/pandoc-word-pagebreak";
        mkdocx-toc = "pandoc --reference-doc /home/tanq/pandoc/SRL_Empty_Document.dotx --filter /home/tanq/pandoc/pandoc-word-pagebreak --toc";
        lpg = "lpass generate --sync=now -c";
        dev = "cd ~/code";
        tb = "taskbook";
        today = "tb -l today";
        aqmd = "ssh -L 5900:marketdata.alphaquants.fund:5900 aqmd";
        aqt1 = "ssh aqt1";
        aqt2 = "ssh aqt2";
        aqdev = "ssh -L 15900:aqtest:5900 aqtest";
        pxz = "xz -T0";
        dt = "dstask";
        dtc = "dstask context";
        dtcn = "dstask context none";
        dta = "dstask add";
        paladin = "dstask context project:nexus.backoffice +nexus";
        nv = "nvim";
      };

      history = {
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        size = 10000;
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
    };

  };
}
