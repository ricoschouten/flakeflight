{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config) programs;
  inherit (lib) mkIf;
in
{
  config = mkIf programs.fish.enable {
    programs.fish = {
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    users.defaultUserShell = pkgs.fish;
  };
}
