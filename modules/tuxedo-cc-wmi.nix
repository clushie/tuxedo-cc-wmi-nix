{ config, lib, pkgs, ... }:

with lib;

let 
    cfg = config.tuxedo-cc-wmi;

    tuxedo-cc-wmi = (
      pkgs.callPackage ../pkgs/tuxedo-cc-wmi/default.nix {
        linuxPackages=config.boot.kernelPackages;
      });
in
  {
    options.tuxedo-cc-wmi = {
      enable = mkEnableOption "tuxedo-cc-wmi";
    };

    config = mkIf cfg.enable 
    {
         boot.kernelModules = ["tuxedo_cc_wmi"];
         boot.extraModulePackages =   [ tuxedo-cc-wmi ];
    };
  }
