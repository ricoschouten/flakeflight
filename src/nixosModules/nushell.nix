{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config) programs;
  inherit (lib) mkIf mkEnableOption;
in
{
  options = {
    programs.nushell.enable = mkEnableOption "nushell";
  };

  config = mkIf programs.nushell.enable {
    users.defaultUserShell = pkgs.nushell;
  };
}
