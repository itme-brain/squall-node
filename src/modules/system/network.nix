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
      hostName = "node.local";
    };
    
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };

    bluetooth.enable = false;
  };
}
