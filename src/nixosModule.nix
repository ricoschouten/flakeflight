{
  lib,
  pkgs,
  inputs,
  hostname,
  ...
}:

let
  inherit (lib) mkDefault;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.users
    self.nixosModules.home-manager
    self.nixosModules.wsl
    self.nixosModules.nh
  ];

  networking.hostName = hostname;

  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };

  programs.nh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
