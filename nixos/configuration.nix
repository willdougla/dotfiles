{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "overflow";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  services.xserver = {
	enable = true;
	videoDrivers = [ "modesetting" ];
	windowManager.bspwm.enable = true;
};

virtualisation.virtualbox.guest.enable = true;
  
  services.xserver.xkb.layout = "br";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.willdougla = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # dev
    vim 
    neovim

    # core  
    wget
    git
    curl

    # terminal
    alacritty
	
    # sistema
    xfce.thunar
    flameshot # ferramenta para print
    pavucontrol
    feh

    # customização
    neofetch
    btop
    picom
    polybar
    rofi
  ];


 fonts.packages = with pkgs; [
   jetbrains-mono
   nerd-fonts.jetbrains-mono
   nerd-fonts.meslo-lg
   material-design-icons
   icomoon-feather
 ];


# Não modificar
  system.stateVersion = "25.11"; 

}

