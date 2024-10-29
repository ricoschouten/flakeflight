{ config, lib, pkgs, ... }:

let
  inherit (config) programs;
  inherit (lib) mkIf mkDefault;
  inherit (pkgs.stdenv) hostPlatform;
in
{
  config = mkIf programs.nh.enable {
    programs.nh = {
      flake = mkDefault "/etc/nixos";
    };

    environment.shellAliases = {
      nixos-rebuild = "nh os";
    };
  };
}
