{ config, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove NF ExtraLight";
      size = 15;
    };
    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    settings = {
      bold_font = "CaskaydiaCove NF Light";
      italic_font = "CaskaydiaCove NF ExtraLightItalic";
      bold_italic_font = "CaskaydiaCove NF LightItalic";
      disable_ligatures = "never";
      scrollback_lines = 100000;
      copy_on_select = "clipboard";
      strip_trailing_spaces = "smart";
      enable_audio_bell = "no";
      foreground = "#d6deeb";
      background = "#011628";
      background_opacity = "0.8";
      hide_window_decorations = "yes";

      #: black
      color0 = "#000000";
      color8 = "#575656";

      #: red
      color1 = "#ef5350";
      color9 = "#ef5350";

      #: green
      color2 =  "#22da6e";
      color10 = "#22da6e";

      #: yellow
      color3 =  "#addb67";
      color11 = "#ffeb95";

      #: blue
      color4 =  "#82aaff";
      color12 = "#82aaff";

      #: magenta
      color5 =  "#c792ea"; 
      color13 = "#c792ea"; 

      #: cyan
      color6 =  "#21c7a8";
      color14 = "#7fdbca";

      #: white
      color7 =  "#ffffff";
      color15 = "#ffffff";

      shell = "nu";
    };
  };
}