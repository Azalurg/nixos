# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    # "nodev" means we generate a GRUB boot menu without intalling GRUB
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  # Network
  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system (display, bspwm)
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
    };
    windowManager.bspwm.enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+bspwm";
  };
  services.xrdp.defaultWindowManager = "bspwm";
  hardware.opengl.enable = true;

  # ZSH
  programs.zsh.enable = true;

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.azalurg = {
    isNormalUser = true;
    description = "azalurg";
    extraGroups = [ "networkmanager" "wheel" "audio" "jackaudio" ]; # "wheel" "input" "audio" "jackaudio" "video" "lp" "networkmanager" "kvm" "libvirtd"
    shell = pkgs.zsh;
 };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Window Manager
    bspwm sxhkd polybar xorg.xdpyinfo xautomation
    rofi feh

    # Tools
    neovim git zsh unzip wget htop tree cmatrix neofetch pavucontrol xclip
    direnv cbonsai oh-my-zsh

    # Applications
    vscodium spotify brave alacritty blender
    jetbrains.pycharm-community 
    python3
    xfce.thunar
  ];

  # services.xserver.desktopManager.xfce.thunarPlugin = [
  #   pkgs.xfce.thunar-archive-plugin
  #   pkgs.xfce.thunar-volman
  # ];

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
