{
  config,
  pkgs,
  ...
}:

{
  # Impostazioni internazionali
  i18n.defaultLocale = "it_IT.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };

  # Impostazioni del sistema
  time.timeZone = "Europe/Rome";

  # Abilita il servizio di rete
  networking = {
    hostName = "nixos"; # Nome host
    networkmanager.enable = true; # NetworkManager gestisce la rete
  };

  # Abilita il desktop environment Plasma (KDE)
  services.xserver = {
    enable = true;
    layout = "it";
    xkbOptions = "eurosign:e";

    displayManager.sddm.enable = true; # Display manager SDDM
    desktopManager.plasma5.enable = true; # Desktop environment Plasma 5

    # Imposta la risoluzione dello schermo
    videoDrivers = [ "modesetting" ];
    monitorSection = ''
      Section "Monitor"
        Identifier "HDMI-1"
        Modeline "1200x900_60.00" 74.25 1200 1272 1400 1600 900 903 913 934 -hsync +vsync
        Option "PreferredMode" "1200x900_60.00"
      EndSection
    '';
  };

  # Pacchetti di base
  environment.systemPackages = with pkgs; [
    vim
    git
    firefox
    libreoffice
    gimp
    vlc
    htop
  ];

  # Abilita il firewall
  networking.firewall.enable = true;

  # Abilita e configura il servizio di stampa
  services.printing.enable = true;

  # Abilita il servizio di sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Abilita i servizi SSH e avvio automatico al boot
  services.openssh.enable = true;

  # Configura gli utenti
  users.users.yourUserName = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "lp" ];
    shell = pkgs.bash;
  };

  # Opzioni di boot
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # Cambiare in base al dispositivo
  };

  # Opzioni di garbage collection e ottimizzazione del sistema
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };
}
