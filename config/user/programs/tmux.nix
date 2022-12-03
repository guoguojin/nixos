{ config, pkgs, nixpkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    shortcut = "a";
    historyLimit = 50000;
    baseIndex = 1;
    escapeTime = 100;
    clock24 = true;
    extraConfig = ''
bind | split-window -h
bind - split-window -v
bind C-a last-window
bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

# Set status bar
set -g status-bg black
set -g status-fg white

# Highlight active window
set-window-option -g window-status-current-style bg=red

# Automatically set window title
#setw -g automatic-rename

set-option -g allow-rename off

#set-option -g mouse-select-pane on
#setw -g mode-mouse on
set-option -g display-time 2000

set -g status-left '#[fg=green]#12H ][#[default]'
# set -g status-left '#P | #[bg=yellow]#S#[bg=cyan] | #7H | %F %s'
set -g status-left-length 60
set -g status-right '#[fg=green] ][ #[fg=blue]%Y-%m-%d #[fg=white]%H:%M:%S#[default]   '
set-option -g status-interval 1
set-option -g default-terminal "xterm-256color"
#set-option -g default-shell /usr/bin/zsh

set -g mouse on

# smart pane switching with awareness of vim splits
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"
bind -n C-c send-keys "clear && tmux clear-history" \; send-keys "Enter"

# Fix for home and end not working with zsh
bind-key -n Home send Escape "OH"
bind-key -n End send Escape "OF"
    '';
    plugins = with pkgs; [
      tmuxPlugins.cpu
      { 
        plugin = tmuxPlugins.resurrect; 
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        ''; 
      }
    ];
  };
}