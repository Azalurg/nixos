# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader = {
    efi ={
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      devices = [ "nodev" ];  # "nodev" means we generate a GRUB boot menu without intalling GRUB
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 3;
      theme = pkgs.emacs28Packages.gruber-darker-theme;
    };

    timeout = 5;
  };

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  

  # Internationalisation
  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.utf8";
    LC_IDENTIFICATION = "pl_PL.utf8";
    LC_MEASUREMENT = "pl_PL.utf8";
    LC_MONETARY = "pl_PL.utf8";
    LC_NAME = "pl_PL.utf8";
    LC_NUMERIC = "pl_PL.utf8";
    LC_PAPER = "pl_PL.utf8";
    LC_TELEPHONE = "pl_PL.utf8";
    LC_TIME = "pl_PL.utf8";
  };

  # Display / Desktop / Windows
  services.xserver = {
    enable = true;
    layout = "pl";
    xkbVariant = "";
    displayManager.lightdm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "azalurg";
    };
    desktopManager.xfce = {
      enable = true;
      enableXfwm = false;
      noDesktop = true;
      thunarPlugins = [ pkgs.xfce.thunar-volman pkgs.xfce.thunar-archive-plugin ];
    };
    windowManager.bspwm.enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+bspwm";
  };
  services.xrdp.defaultWindowManager = "bspwm";
  hardware.opengl.enable = true;

  # Audio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback.enable = true;
  };
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # ZSH
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.azalurg = {
    isNormalUser = true;
    description = "azalurg";
    extraGroups = [ "networkmanager" "wheel" "audio" "jackaudio" "video" "lp" ]; # "kvm" "libvirtd"
    shell = pkgs.zsh;
 };

  # Packages
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;
  
  environment.systemPackages = with pkgs; [
    # Window Manager
    bspwm sxhkd polybar xorg.xdpyinfo xautomation
    rofi feh

    # Tools
    neovim git unzip wget htop tree cmatrix neofetch pavucontrol xclip
    direnv cbonsai

    # Applications
    vscodium spotify brave alacritty blender
    jetbrains.pycharm-community 
    python3
  ];

  # Environment variables
  environment.variables = {
    EDITOR = "nvim";
  };

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
  system.stateVersion = "22.05"; # Did you read the comment?

}
