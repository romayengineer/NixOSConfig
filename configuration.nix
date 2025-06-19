# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the Docker daemon service
  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maxirom7 = {
    isNormalUser = true;
    description = "maxirom7";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      # "pipe-operators"
    ];
  };

  # Microsoft teams is not supported
  # This is to support for example micorsoft teams
  # nixpkgs.config.allowUnsupportedSystem = true;

  security.pki.certificateFiles = [
    ./certs/citrix/healthfirst.org.pem
    ./certs/citrix/healthfirst.org.digicert.pem
    ./certs/citrix/healthfirst.org.digicert.global.pem
  ];

  nixpkgs.overlays = [
    (self: super: {
      # This patches the hash for workspacesclient.nix that aws-workspaces depends on
      aws-workspaces = self.callPackage ./patches/nixpkgs/pkgs/by-name/aw/aws-workspaces/package.nix { };
      # Download .tar.gz from https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
      # Then run nix-prefetch-url file://$PWD/linuxx64-25.03.0.66.tar.gz
      # Old Implementation
      # citrix_workspace = (self.callPackage ./patches/nixpkgs/pkgs/applications/networking/remote/citrix-workspace/default.nix { }).citrix_workspace_25_03_0;
      # Lets call generic.nix directly
      citrix_workspace = (self.callPackage ./patches/nixpkgs/pkgs/applications/networking/remote/citrix-workspace/generic.nix {
        hash = "0fwqsxggswms40b5k8saxpm1ghkxppl27x19w8jcslq1f0i1fwqx";
        homepage = "https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html";
        prefix = "linuxx64";
        version = "25.05.0.44";
      });
      # every time there is an update run this command
      # nix-prefetch-url file://$PWD/linuxx64-25.05.0.44.tar.gz
      # path is '/nix/store/g2icf19is4l443fvzrrq1w4gf9lnkqbj-linuxx64-25.05.0.44.tar.gz'
      # 0fwqsxggswms40b5k8saxpm1ghkxppl27x19w8jcslq1f0i1fwqx
      #
      # once the nix-prefetch-url command is run the .tar.gz can be deleted as now is stored in /nix/store/
    })
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # Use the new option and point it to the actual GNOME 3 pinentry package.
    # This is necessary to run gpg --full-generate-key this pinentry asks for the password
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs.steam.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ]; # Use the modern kernel driver

  nixpkgs.config.supportedSystems = [ "x86_64-linux" "i686-linux" ];

  hardware.graphics = {
    enable = true;
    # This is the single most important line for Steam to work.
    enable32Bit = true;
    # Add extra packages for full Vulkan and video acceleration support.
    extraPackages = with pkgs; [
      intel-media-driver  # For video decoding
      vulkan-loader       # The main Vulkan loader
      vulkan-tools        # Provides useful Vulkan utilities
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.vulkan-loader
    ];
  };

  # Optional but recommended: Explicitly enable Vulkan support
  # hardware.vulkan.enable = true; # This like triggers the error !!!
  # hardware.vulkan.intel.enable = true;

  services.flatpak.enable = true;
  # configure flathub
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop
    gnome-browser-connector
    # Audio
    pavucontrol # let me increase volume higher than 100%
    # Package managers
    flatpak
    # Shell Utils
    wget
    ripgrep
    gnupg
    openssl
    htop
    lsof
    # Browsers
    chromium
    ### to install google-chrome
    ### flatpak install flathub com.google.Chrome
    # Tools for VDI / Conference / etc
    zoom-us
    aws-workspaces
    citrix_workspace
    ### teams # Not supported use in browser instead
    # Code IDE / Interpreter / Compilers / etc
    git
    vim
    vscode
    jetbrains.idea-community
    python314
    docker
    docker-compose
    stdenv # c++ compiler
    # Docs
    obsidian
    # Gaming
    ## steam
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
