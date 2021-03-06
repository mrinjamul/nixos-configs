# Injamul Mohammad Mollah <mrinjamul@gmail.com> © 2021
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;
  # networking.wireless.networks = {
  #  "Injamul" = {         # SSID with spaces and/or special characters
  #     psk = "xInjamul";
  #   };
  # };


 
  # enable network Manager
  networking.networkmanager.enable = true;
  # nm and wpa can be used together
  # networking.networkmanager.unmanaged = [
  #   "*" "except:type:wwan" "except:type:gsm"
  # ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = true; # disable it if you are using nmcli
  networking.interfaces.enp9s0.useDHCP = true;
  # networking.interfaces.enp0s3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.injamul = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
     openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAdBDm14oS8IVMFIdvbfKIYKq1/lT1bbnTalKvtjo7a8T1XvpoVhSsqkPq3l0IXXC+I+LJWph031T6gcgA0EMMphBv8zdu7wFBBCDpdtv0EAwIokMQLX8x6++CDbeXA6mrNsbhuBmvObtDyHXMDv7P48pZfdl4Ga6zcTLqQjM1QdWc8RJ36h+QpP3Bmr95ZZbaiKCdGWZkSaDLjULWFEqsEn+CiAA22W1Q7xUosQ6AinLlCc+hypzONebYPFxdOMERdYU6PF8/A1XyIPMPgzLH5JE7TD+DqnxwFlw1sRIX9HPwBQ6tBT0Fhg3DQLxv1k/KHpmz6AssMhKYXqZcRywzgJ2YiiFFra1tQ4ikL9Rc5H2zV2A/2M6jKIfP6uVxvgNoMrloSO8rHaXLMgXlCWegcUEcmzLPp5SlwIIqokZS4vdfXPSnKJ6KfFQSKLBvWdcPB1jS2wTG1X9PATx109pJ2rnlKfUriwY5SemUoC/yydOYFrg5P+EEA+c6YFHx85wK2Jd2UXu9zfIRynlnIsFnoS34anXzHDkhNfDkyxp+ubIFmocNGNhYV6YYSDRpRKAaxBfowsNbSJt3Nc4tSa3u0gh2dk8gXyhytdUQLk2du+qc+A9TRGP3brGY8WC8Z1OKE/MjdzOIM37PqUcrkgm2e+0fV6m4/y1ZXSw4jd6TwQ== mrinjamul@gmail.com" ];
     # shell = pkgs.zsh; # default zsh for me
   };

  # Enable proprietary software sources 
  nixpkgs.config.allowUnfree = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # editors
     vim
     # cli programs
     xsel
     pciutils
     powertop
     tree
     wget
     curl
     htop
     nmap
     neofetch
     tmux
     cmus
     git
     # gui programs
     firefox
     mpv
     # extras
     go
     nodejs
     vscode
   ];

  # Virtualbox
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "injamul" ];
  # virtualisation.virtualbox.host.enableExtensionPack = true; # For usb2 and usb3 support


  #----=[ Fonts ]=----#
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];

  # enable zsh
  programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh; # for all users

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "21.05"; # Did you read the comment?

}

