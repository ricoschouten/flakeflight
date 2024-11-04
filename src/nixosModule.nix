{ inputs, hostname, ... }:

let
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.users
    self.nixosModules.home-manager
    self.nixosModules.wsl
    self.nixosModules.nh
  ];

  users.defaultUserShell = pkgs.fish;
  networking.hostName = hostname;

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
