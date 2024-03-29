{ config, lib, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
# Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreeRedistributable = true;
      # Some times packages are blocked by Nix because they have been labelled as insecure
      # To allow their installation anyway, we can add them to the list
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
    };
    overlays = import ./overlays;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # SDDM because LightDM can be a fickle bitch
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "chili";

  # Enable the XFCE Desktop Environment.
  # By default we'll set Xfce as our desktop environment 
  # and we can pull in the i3 configuration if we want to use
  # i3 instead. 
  # Later we might add other WM's or DE's
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "eurosign:e";
    dpi = 96;
  };

  # Configure console keymap
  console.keyMap = "us";
  console.font = "Lat2-Terminus16";

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      powerline-fonts
      #nerdfonts
      source-code-pro
      font-awesome
      corefonts
      carlito
      vegur
      cantarell-fonts
      cascadia-code
      noto-fonts
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.mouse.naturalScrolling = true;

  # Define a user account. Don't forget to reset the password with ‘passwd’ after your first login.
  users.users.tanq = {
    isNormalUser = true;
    description = "Tan Quach";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialHashedPassword = "$y$j9T$O8UhqhbK5TrAGRfOwJsOg0$OoH7P05aqaEzlC/LVNps8DrU5v87drFDn52Nfss04Q/";
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  # required to make i3blocks to work
  environment.pathsToLink = [
    "/libexec"
  ];

  # Environment variables that should be persistent across all sessions.
  # environment.sessionVariables = {
  #   GOPRIVATE = "gitlab.com/gobl,gitlab.com/gofp,gitlab.com/oakenfield-services";
  # };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enableb:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = false;
    };
  };   

  services.gnome.gnome-keyring.enable = true;

  programs = {
    dconf.enable = true;
    nm-applet.enable = true;
    fuse.userAllowOther = true;
  };

  # Virtualisation configuration
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  environment.systemPackages = with pkgs; [
    # essential
    vim                         # system wide vim with no plugins or config set
    neovim
    gnome.gnome-keyring
    gnome.libgnome-keyring

    # theming
    lxappearance
    qogir-theme
    qogir-icon-theme
    sddm-chili-theme
    catppuccin-gtk

    # common coding
    git
    lazygit
    gcc
    gitflow
    gnumake
    nodejs
    pre-commit
    tree-sitter
    rnix-lsp
    direnv
    nix-direnv
    universal-ctags
    docker-compose

    # terminals
    terminator
    alacritty
    tmux
    kitty

    # apps
    gparted
    spotify
    libreoffice-fresh
    remmina
    font-manager
    arandr

    # cli
    wget
    curl
    neofetch
    dstask
    ripgrep
    xsel
    bat
    fd
    youtube-dl
    pandoc

    # utils
    autorandr
    unzip
    tree
    mosh
    fakeroot
    killall
    lm_sensors
    pciutils
    usbutils
    pulseaudio-ctl
    libnotify

    # messaging
    telegram-desktop
    slack
    whatsapp-for-linux
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
