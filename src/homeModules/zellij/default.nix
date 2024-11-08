{ config, lib, ... }:

let
  inherit (config) programs;
  inherit (lib)
    mkIf
    mkOption
    mkEnableOption
    isString
    isPath
    readFile
    ;

  inherit (lib.types) lines path either;

  mkIfString = x: mkIf (isString x) x;
  mkIfPath = x: mkIf (isPath x) x;
in
{
  imports = [
    ./plugins/zjstatus
  ];

  options = {
    programs.zellij = {
      layout = mkOption {
        type = either lines path;
        default = ./default.kdl;
        description = "The default layout.";
      };

      shellIntegration = {
        autoAttach = mkEnableOption "Automatically attach to Zellij";
        autoExit = mkEnableOption "Automatically exit with Zellij";
      };

      enableNushellIntegration = mkEnableOption "Enable Zellij Nushell integration";
    };
  };

  config = mkIf programs.zellij.enable {
    xdg.configFile."zellij-layout" = {
      enable = true;
      target = "zellij/layouts/default.kdl";
      text = mkIfString programs.zellij.layout;
      source = mkIfPath programs.zellij.layout;
    };

    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = mkIf programs.zellij.shellIntegration.autoAttach "true";
      ZELLIJ_AUTO_EXIT = mkIf programs.zellij.shellIntegration.autoExit "true";
    };

    programs.nushell = mkIf programs.zellij.enableNushellIntegration {
      extraConfig = readFile ./auto-start.nu;

      environmentVariables = {
        ZELLIJ_AUTO_ATTACH = mkIf programs.zellij.shellIntegration.autoAttach "true";
        ZELLIJ_AUTO_EXIT = mkIf programs.zellij.shellIntegration.autoExit "true";
      };
    };
  };
}
