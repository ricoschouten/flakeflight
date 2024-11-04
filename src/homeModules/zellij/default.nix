{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

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

  inherit (lib.types) str path either;
  inherit (pkgs.stdenv) hostPlatform;
  inherit (inputs) zjstatus;

  mkIfString = x: mkIf (isString x) x;
  mkIfPath = x: mkIf (isPath x) x;
in
{
  options = {
    programs.zellij = {
      layout = mkOption {
        type = either str path;
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
    programs.zellij.settings.plugins."zjstatus" = {
      _props.location = "file:${zjstatus.packages.${hostPlatform.system}.default}/bin/zjstatus.wasm";
    };

    xdg.configFile."zellij-layout" = {
      enable = true;
      target = "zellij/layouts/default.kdl";
      text = mkIfString programs.zellij.layout;
      source = mkIfPath programs.zellij.layout;
    };

    programs.nushell.extraConfig = mkIf programs.zellij.enableNushellIntegration (readFile ./config.nu);

    home.sessionVariables = {
      ZELLIJ_AUTO_ATTACH = mkIf programs.zellij.shellIntegration.autoAttach "true";
      ZELLIJ_AUTO_EXIT = mkIf programs.zellij.shellIntegration.autoExit "true";
    };
  };
}
