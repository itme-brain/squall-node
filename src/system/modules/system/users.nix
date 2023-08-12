{ config, pkgs, ... }:

{
  users.users = {
    root = {
      password = "!";
      createHome = false;
    };

    squall = {
      isNormalUser = true;
      extraGroups = [ "wheel" "bitcoin" ];
      initialPassword = "satoshi";
    };

    core = {
      isSystemUser = true;
      extraGroups = [ "bitcoin" ];
      shell = "/usr/bin/false";
    };

    electrum = {
      isSystemUser = true;
      extraGroups = [ "bitcoin" ];
      shell = "/usr/bin/false";
    };

    lightning = {
      isSystemUser = true;
      extraGroups = [ "bitcoin" ];
      shell = "/usr/bin/false";
    };
  };
}
