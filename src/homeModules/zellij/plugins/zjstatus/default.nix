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
    mkDefault
    mkMerge
    mkOption
    mkEnableOption
    mkPackageOption
    ;

  inherit (pkgs.stdenv) hostPlatform;
  inherit (inputs) zjstatus;

  yaml = pkgs.formats.yaml { };
in
{
  options = {
    programs.zellij.plugins.zjstatus = {
      enable = mkEnableOption "zjstatus";

      package = mkPackageOption zjstatus.packages.${hostPlatform.system} "zjstatus" {
        default = [ "default" ];
        example = "pkgs.zjstatus";
      };

      settings = mkOption {
        type = yaml.type;
        default = { };
      };
    };
  };

  config = mkIf programs.zellij.enable {
    programs.zellij.settings.plugins.zjstatus = mkIf programs.zellij.plugins.zjstatus.enable (mkMerge [
      programs.zellij.plugins.zjstatus.settings
      {
        _props.location = mkDefault "file:${programs.zellij.plugins.zjstatus.package}/bin/zjstatus.wasm";
      }
    ]);
  };
}
