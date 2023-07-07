{ config, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let dark_theme = {
        # color for nushell primitives
        separator: white
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: green_bold
        empty: blue
        # Closures can be used to choose colors for specific values.
        # The value (in this case, a bool) is piped into the closure.
        bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
        int: white
        filesize: {|e|
          if $e == 0b {
            'white'
          } else if $e < 1mb {
            'cyan'
          } else { 'blue' }
        }
        duration: white
        date: {|| (date now) - $in |
          if $in < 1hr {
            'purple'
          } else if $in < 6hr {
            'red'
          } else if $in < 1day {
            'yellow'
          } else if $in < 3day {
            'green'
          } else if $in < 1wk {
            'light_green'
          } else if $in < 6wk {
            'cyan'
          } else if $in < 52wk {
            'blue'
          } else { 'dark_gray' }
        }
        range: white
        float: white
        string: white
        nothing: white
        binary: white
        cellpath: white
        row_index: green_bold
        record: white
        list: white
        block: white
        hints: dark_gray
        search_result: {bg: red fg: white}

        shape_and: purple_bold
        shape_binary: purple_bold
        shape_block: blue_bold
        shape_bool: light_cyan
        shape_closure: green_bold
        shape_custom: green
        shape_datetime: cyan_bold
        shape_directory: cyan
        shape_external: cyan
        shape_externalarg: green_bold
        shape_filepath: cyan
        shape_flag: blue_bold
        shape_float: purple_bold
        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: white bg: red attr: b}
        shape_globpattern: cyan_bold
        shape_int: purple_bold
        shape_internalcall: cyan_bold
        shape_list: cyan_bold
        shape_literal: blue
        shape_match_pattern: green
        shape_matching_brackets: { attr: u }
        shape_nothing: light_cyan
        shape_operator: yellow
        shape_or: purple_bold
        shape_pipe: purple_bold
        shape_range: yellow_bold
        shape_record: cyan_bold
        shape_redirection: purple_bold
        shape_signature: green_bold
        shape_string: green
        shape_string_interpolation: cyan_bold
        shape_table: blue_bold
        shape_variable: purple
        shape_vardecl: purple
      }

      let light_theme = {
        # color for nushell primitives
        separator: dark_gray
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: green_bold
        empty: blue
        # Closures can be used to choose colors for specific values.
        # The value (in this case, a bool) is piped into the closure.
        bool: {|| if $in { 'dark_cyan' } else { 'dark_gray' } }
        int: dark_gray
        filesize: {|e|
          if $e == 0b {
            'dark_gray'
          } else if $e < 1mb {
            'cyan_bold'
          } else { 'blue_bold' }
        }
        duration: dark_gray
        date: {|| (date now) - $in |
          if $in < 1hr {
            'purple'
          } else if $in < 6hr {
            'red'
          } else if $in < 1day {
            'yellow'
          } else if $in < 3day {
            'green'
          } else if $in < 1wk {
            'light_green'
          } else if $in < 6wk {
            'cyan'
          } else if $in < 52wk {
            'blue'
          } else { 'dark_gray' }
        }
        range: dark_gray
        float: dark_gray
        string: dark_gray
        nothing: dark_gray
        binary: dark_gray
        cellpath: dark_gray
        row_index: green_bold
        record: white
        list: white
        block: white
        hints: dark_gray
        search_result: {fg: white bg: red}

        shape_and: purple_bold
        shape_binary: purple_bold
        shape_block: blue_bold
        shape_bool: light_cyan
        shape_closure: green_bold
        shape_custom: green
        shape_datetime: cyan_bold
        shape_directory: cyan
        shape_external: cyan
        shape_externalarg: green_bold
        shape_filepath: cyan
        shape_flag: blue_bold
        shape_float: purple_bold
        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: white bg: red attr: b}
        shape_globpattern: cyan_bold
        shape_int: purple_bold
        shape_internalcall: cyan_bold
        shape_list: cyan_bold
        shape_literal: blue
        shape_match_pattern: green
        shape_matching_brackets: { attr: u }
        shape_nothing: light_cyan
        shape_operator: yellow
        shape_or: purple_bold
        shape_pipe: purple_bold
        shape_range: yellow_bold
        shape_record: cyan_bold
        shape_redirection: purple_bold
        shape_signature: green_bold
        shape_string: green
        shape_string_interpolation: cyan_bold
        shape_table: blue_bold
        shape_variable: purple
        shape_vardecl: purple
      }

      # External completer example
      # let carapace_completer = {|spans|
      #     carapace $spans.0 nushell $spans | from json
      # }


      # The default config record. This is where much of your global configuration is setup.
      let-env config = {
        # true or false to enable or disable the welcome banner at startup
        show_banner: false
        ls: {
          use_ls_colors: true # use the LS_COLORS environment variable to colorize output
          clickable_links: true # enable or disable clickable links. Your terminal has to support links.
        }
        rm: {
          always_trash: false # always act as if -t was given. Can be overridden with -p
        }
        cd: {
          abbreviations: false # allows `cd s/o/f` to expand to `cd some/other/folder`
        }
        table: {
          mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
          index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
          show_empty: true # show 'empty list' and 'empty record' placeholders for command output
          trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
          }
        }

        # datetime_format determines what a datetime rendered in the shell would look like.
        # Behavior without this configuration point will be to "humanize" the datetime display,
        # showing something like "a day ago."

        datetime_format: {
          normal: '%a, %d %b %Y %H:%M:%S %z'  # shows up in displays of variables or other datetime's outside of tables
          # table: '%m/%d/%y %I:%M:%S%p'        # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
        }

        explore: {
          help_banner: true
          exit_esc: true

          command_bar_text: '#C4C9C6'
          # command_bar: {fg: '#C4C9C6' bg: '#223311' }

          status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
          # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }

          highlight: {bg: 'yellow' fg: 'black' }

          status: {
            # warn: {bg: 'yellow', fg: 'blue'}
            # error: {bg: 'yellow', fg: 'blue'}
            # info: {bg: 'yellow', fg: 'blue'}
          }

          try: {
            # border_color: 'red'
            # highlighted_color: 'blue'

            # reactive: false
          }

          table: {
            split_line: '#404040'

            cursor: true

            line_index: true
            line_shift: true
            line_head_top: true
            line_head_bottom: true

            show_head: true
            show_index: true

            # selected_cell: {fg: 'white', bg: '#777777'}
            # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
            # selected_column: blue

            # padding_column_right: 2
            # padding_column_left: 2

            # padding_index_left: 2
            # padding_index_right: 1
          }

          config: {
            cursor_color: {bg: 'yellow' fg: 'black' }

            # border_color: white
            # list_color: green
          }
        }

        history: {
          max_size: 100_000 # Session has to be reloaded for this to take effect
          sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
          file_format: "plaintext" # "sqlite" or "plaintext"
          isolation: true # true enables history isolation, false disables it. true will allow the history to be isolated to the current session. false will allow the history to be shared across all sessions.
        }
        completions: {
          case_sensitive: false # set to true to enable case-sensitive completions
          quick: true  # set this to false to prevent auto-selecting completions when only one remains
          partial: true  # set this to false to prevent partial filling of the prompt
          algorithm: "fuzzy"  # prefix or fuzzy
          external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: null # check 'carapace_completer' above as an example
          }
        }
        filesize: {
          metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
          format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
        }
        cursor_shape: {
          emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line (line is the default)
          vi_insert: line # block, underscore, line , blink_block, blink_underscore, blink_line (block is the default)
          vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line (underscore is the default)
        }
        color_config: $dark_theme   # if you want a light theme, replace `$dark_theme` to `$light_theme`
        use_grid_icons: true
        footer_mode: "25" # always, never, number_of_rows, auto
        float_precision: 2 # the precision for displaying floats in tables
        # buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
        use_ansi_coloring: true
        bracketed_paste: true # enable bracketed paste, currently useless on windows
        edit_mode: emacs # emacs, vi
        shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
        render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

        hooks: {
          pre_execution: [{||
            null  # replace with source code to run before the repl input is run
          }]
          env_change: {
            PWD: [{|before, after|
              null  # replace with source code to run if the PWD environment is different since the last repl input
            }]
          }
          display_output: {||
            if (term size).columns >= 100 { table -e } else { table }
          }
          command_not_found: {
            |cmd_name| (
              try {
                let pkgs = (pkgfile --binaries --verbose $cmd_name)
                if ($pkgs | is-empty) {
                  return null
                }
                (
                  $"(ansi $env.config.color_config.shape_external)($cmd_name)(ansi reset) " +
                  $"may be found in the following packages:\n($pkgs)"
                )
              }
            )
          }
        }
        menus: [
          # Configuration for default nushell menus
          # Note the lack of source parameter
          {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
              layout: columnar
              columns: 4
              col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
              col_padding: 2
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
          }
          {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
              layout: list
              page_size: 10
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
          }
          {
            name: help_menu
            only_buffer_difference: true
            marker: "? "
            type: {
              layout: description
              columns: 4
              col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
              col_padding: 2
              selection_rows: 4
              description_rows: 10
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
          }
          # Example of extra menus created using a nushell source
          # Use the source field to create a list of records that populates
          # the menu
          {
            name: commands_menu
            only_buffer_difference: false
            marker: "# "
            type: {
              layout: columnar
              columns: 4
              col_width: 20
              col_padding: 2
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
            source: { |buffer, position|
              scope commands
              | where name =~ $buffer
              | each { |it| {value: $it.name description: $it.usage} }
            }
          }
          {
            name: vars_menu
            only_buffer_difference: true
            marker: "# "
            type: {
              layout: list
              page_size: 10
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
            source: { |buffer, position|
              scope variables
              | where name =~ $buffer
              | sort-by name
              | each { |it| {value: $it.name description: $it.type} }
            }
          }
          {
            name: commands_with_description
            only_buffer_difference: true
            marker: "# "
            type: {
              layout: description
              columns: 4
              col_width: 20
              col_padding: 2
              selection_rows: 4
              description_rows: 10
            }
            style: {
              text: green
              selected_text: green_reverse
              description_text: yellow
            }
            source: { |buffer, position|
              scope commands
              | where name =~ $buffer
              | each { |it| {value: $it.name description: $it.usage} }
            }
          }
        ]
        keybindings: [
          {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
              until: [
                { send: menu name: completion_menu }
                { send: menunext }
              ]
            }
          }
          {
            name: completion_previous
            modifier: shift
            keycode: backtab
            mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
            event: { send: menuprevious }
          }
          {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: emacs
            event: { send: menu name: history_menu }
          }
          {
            name: next_page
            modifier: control
            keycode: char_x
            mode: emacs
            event: { send: menupagenext }
          }
          {
            name: undo_or_previous_page
            modifier: control
            keycode: char_z
            mode: emacs
            event: {
              until: [
                { send: menupageprevious }
                { edit: undo }
              ]
              }
          }
          {
            name: yank
            modifier: control
            keycode: char_y
            mode: emacs
            event: {
              until: [
                {edit: pastecutbufferafter}
              ]
            }
          }
          {
            name: unix-line-discard
            modifier: control
            keycode: char_u
            mode: [emacs, vi_normal, vi_insert]
            event: {
              until: [
                {edit: cutfromlinestart}
              ]
            }
          }
          {
            name: kill-line
            modifier: control
            keycode: char_k
            mode: [emacs, vi_normal, vi_insert]
            event: {
              until: [
                {edit: cuttolineend}
              ]
            }
          }
          # Keybindings used to trigger the user defined menus
          {
            name: commands_menu
            modifier: control
            keycode: char_t
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: commands_menu }
          }
          {
            name: vars_menu
            modifier: alt
            keycode: char_o
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: vars_menu }
          }
          {
            name: commands_with_description
            modifier: control
            keycode: char_s
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menu name: commands_with_description }
          }
        ]
      }
  '';
  envFile.text = ''
    # The prompt indicators are environmental variables that represent
    # the state of the prompt
    let-env PROMPT_INDICATOR = {|| "> " }
    let-env PROMPT_INDICATOR_VI_INSERT = {|| ": " }
    let-env PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
    let-env PROMPT_MULTILINE_INDICATOR = {|| "::: " }

    # Specifies how environment variables are:
    # - converted from a string to a value on Nushell startup (from_string)
    # - converted from a value back to a string when running external commands (to_string)
    # Note: The conversions happen *after* config.nu is loaded
    let-env ENV_CONVERSIONS = {
      "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
      }
      "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
      }
    }

    # Directories to search for scripts when calling source or use
    #
    # By default, <nushell-config-dir>/scripts is added
    let-env NU_LIB_DIRS = [
        ($nu.default-config-dir | path join 'scripts')
    ]

    # Directories to search for plugin binaries when calling register
    #
    # By default, <nushell-config-dir>/plugins is added
    let-env NU_PLUGIN_DIRS = [
        ($nu.default-config-dir | path join 'plugins')
    ]

    # To add entries to PATH (on Windows you might use Path), you can use the following pattern:
    # let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
  '';
  shellAliases = {
    ptar = "XZ_OPT=\"-T0\" tar";
    reap = "mosh tanq@reaper.birchwoodlangham.com -- /home/tanq/bin/tm";
    hellcat = "mosh tanq@hellcat.birchwoodlangham.com -- /home/tanq/bin/tm";
    rebuild-fonts = "sudo fc-cache -f";
    mkdocx = "pandoc --reference-doc /home/tanq/pandoc/SRL_Empty_Document.dotx --filter /home/tanq/pandoc/pandoc-word-pagebreak";
    mkdocx-toc = "pandoc --reference-doc /home/tanq/pandoc/SRL_Empty_Document.dotx --filter /home/tanq/pandoc/pandoc-word-pagebreak --toc";
    lpg = "lpass generate --sync=now -c";
    dev = "cd ~/code";
    td = "todo.sh";
    updatedbx = "updatedb -l 0 -o $env.HOME/.external-media.db -U /run/media/tanq";
    locatex = "locate -d $env.HOME/.external-media.db:";
    jrnl = " jrnl";
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
    nv = "nvim";
    lv = "lvim";
    nsff = "xpra start ssh://tanq@nightshade.noip.me:2222/ --exit-with-children --opengl = no --start-child = \"firefox -no-remote\"";
    nsdesk = "xpra start-desktop --start-child = xfce4-session --exit-with-children --speaker = off --opengl = off --resize-display = 3815x2080 ssh://tanq@nightshade.noip.me:2222/";
    ns = "/home/tanq/bin/nsrun kitty tm";
    ll = "ls -al";
    lls = "^exa --icons -F -H --group-directories-first --git -l";
    cat = "bat";

    #list
    la = "ls -a";
    l = "ls";

    #fix obvious typos
    "cd.." = "cd ..";
    pdw = "pwd";

    ## Colorize the grep command output for ease of use (good for log files)##
    grep = "grep --color = auto";
    egrep = "egrep --color = auto";
    fgrep = "fgrep --color = auto";

    #readable output
    df = "df -h";

    #free
    free = "free -mt";

    #userlist
    userlist = "cut -d: -f1 /etc/passwd";

    #add new fonts
    fcc = "sudo fc-cache -fv";

    #quickly kill conkies
    kc = "killall conky";

    #hardware info --short
    hw = "hwinfo --short";

    #check vulnerabilities microcode
    microcode = "grep . /sys/devices/system/cpu/vulnerabilities/*";

    #youtube-dl
    yta-aac = "youtube-dl --extract-audio --audio-format aac";
    yta-best = "youtube-dl --extract-audio --audio-format best";
    yta-flac = "youtube-dl --extract-audio --audio-format flac";
    yta-m4a = "youtube-dl --extract-audio --audio-format m4a";
    yta-mp3 = "youtube-dl --extract-audio --audio-format mp3";
    yta-opus = "youtube-dl --extract-audio --audio-format opus";
    yta-vorbis = "youtube-dl --extract-audio --audio-format vorbis";
    yta-wav = "youtube-dl --extract-audio --audio-format wav";

    ytv-best = "youtube-dl -f bestvideo+bestaudio";

    #get the error messages from journalctl
    jctl = "journalctl -p 3 -xb";

    # alias code = code --disable-gpu
    ws1 = "i3-msg workspace \"1\"";
    ws2 = "i3-msg workspace \"2\"";
    ws3 = "i3-msg workspace \"3\"";
    ws4 = "i3-msg workspace \"4\"";
    ws5 = "i3-msg workspace \"5\"";
    ws6 = "i3-msg workspace \"6\"";
    ws7 = "i3-msg workspace \"7\"";
    ws8 = "i3-msg workspace \"8\"";
    ws9 = "i3-msg workspace \"9\"";
    ws10 = "i3-msg workspace \"10\"";
    ws11 = "i3-msg workspace \"11\"";
    ws12 = "i3-msg workspace \"12\"";
    ws13 = "i3-msg workspace \"13\"";
    ws14 = "i3-msg workspace \"14\"";
    ws15 = "i3-msg workspace \"15\"";
    ws16 = "i3-msg workspace \"16\"";
    ws17 = "i3-msg workspace \"17\"";
    ws18 = "i3-msg workspace \"18\"";
    ws19 = "i3-msg workspace \"19\"";
    ws20 = "i3-msg workspace \"20\"";

    aqa = "t add +alhambra";
    aql = "t +alhambra";
    aqall = "t +alhambra all";
    tks = "t sync";
  };
  environmentVariables = {
    GOPATH = "$'($env.HOME)/go'";
    GOPRIVATE = "gitlab.com/gobl,gitlab.com/oakenfield-services,gitlab.com/gofp";
    DOCKER_BUILDKIT = "1";
    CGO_ENABLED = "0";

    # Oh-My-Posh prompt configuration
    POWERLINE_COMMAND = "oh-my-posh";
    POSH_THEME = "~/.config/oh-my-posh/config.json";
    PROMPT_INDICATOR = "''";
    POSH_PID = "(random uuid)";
    # By default displays the right prompt on the first line
    # making it annoying when you have a multiline prompt
    # making the behavior different compared to other shells
    PROMPT_COMMAND_RIGHT = "''";
    POSH_SHELL_VERSION = "(version | get version)";

    # PROMPTS
    PROMPT_MULTILINE_INDICATOR = ''(^"oh-my-posh" print secondary $"--config=($env.POSH_THEME)\" --shell=nu $\"--shell-version=($env.POSH_SHELL_VERSION)")'';

    PROMPT_COMMAND = ''{ ||
        # We have to do this because the initial value of `$env.CMD_DURATION_MS` is always `0823`,
        # which is an official setting.
        # See https://github.com/nushell/nushell/discussions/6402#discussioncomment-3466687.
        let cmd_duration = if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS }

        # hack to set the cursor line to 1 when the user clears the screen
        # this obviously isn't bulletproof, but it's a start
        let clear = (history | last 1 | get 0.command) == "clear"

        let width = ((term size).columns | into string)
        ^"oh-my-posh" print primary $"--config=($env.POSH_THEME)" --shell=nu $"--shell-version=($env.POSH_SHELL_VERSION)" $"--execution-time=($cmd_duration)" $"--error=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)" $"--cleared=($clear)"
        }
    '';

    PATH = ''($env.PATH | prepend [$'($env.HOME)/bin', $'($env.HOME)/.local/bin'] | append [$'($env.GOPATH)/bin', $'($env.HOME)/.cargo/bin'])'';
  };
  extraConfig = ''
    # Searches Last Pass for the password records that match the given description
    def lps [
      name: string  # The name of the Last Pass record to match
    ] {
      lpass ls |
      lines |
      where (str contains -i $name) |
      split column " [id: " name id |
      str trim -c "]"
    }

    # Copy the user name for the given password id into the clipboard
    def lpu [
      id: string  # The id of the password to retrieve the user name from
    ] {
      lpass show --user $id | xclip
    }

    # Copy the password for the given password id into the clipboard
    def lpp [
      id: string  # The id of the record to retrieve the password from
    ] {
      lpass show --password $id | xclip
    }

    # Display the Last Pass record to StdOut
    def lpshow [
      id: string  # The id of the record to show 
    ] {
      lpass show $id
    }

    # Copy the notes from the Last Pass record to the clipboard
    def lpnotes [
      id: string  # The id of the record to copy notes from
    ] {
      lpass show --notes $id | xclip
    }

    # Recently installed packages
    def rip [
      n: int   # N results to list
    ] {
      expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' |
      lines |
      split column "\t" time package |
      sort-by time -r |
      first $n
    }

    # Cleanup orphaned packages
    def clean [] {
      sudo pacman -Rns (pacman -Qtdq | lines)
    }

    # List unneeded packages
    def ls-unneeded [] {
      pacman -Qqd | pacman -Rsu --print -
    }

    # Remove unneeded packages
    def rm-unneeded [] {
      pacman -Qqd | pacman -Rsu -
    }

    # List processes whose name matches the given input
    def psgrep [
      name: string  # Name of the process to match
    ] {
      ps | where name =~ $name
    }'';
  };
}
