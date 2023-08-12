{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "node";
    useDHCP = lib.mkDefault true;
    wireless.enable = false;
  };
  
  services = { 
    avahi = {
      enable = true;
      hostName = "squall.local";
    };
    
    openssh = {
      enable = true;
      startWhenNeeded = true;
      permitRootLogin = "no";
    };

    bluetooth.enable = false;
  };
}
