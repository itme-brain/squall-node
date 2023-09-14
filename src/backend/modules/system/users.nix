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
  };

  security.sudo.execWheelOnly = true;
}
