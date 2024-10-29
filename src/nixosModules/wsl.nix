{
  config,
  lib,
  inputs,
  username,
  ...
}:

let
  inherit (config) wsl;
  inherit (lib) mkIf mkOverride;
  inherit (inputs) nixos-wsl;
in
{
  imports = [ nixos-wsl.nixosModules.default ];
  
  config = mkIf wsl.enable {
    wsl.defaultUser = username;
  };
}