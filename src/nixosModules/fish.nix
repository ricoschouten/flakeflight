{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config) programs;
  inherit (lib) mkIf mkDefault;
in
{
  config = mkIf programs.fish.enable {
    programs.fish = {
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    users.defaultUserShell = mkDefault pkgs.fish;
  };
}
