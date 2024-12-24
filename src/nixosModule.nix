{ inputs, ... }:

let
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.users
    self.nixosModules.home-manager
    self.nixosModules.wsl
    self.nixosModules.minecraft
    self.nixosModules.nh
    self.nixosModules.fish
    self.nixosModules.nushell
  ];

  programs = {
    nushell.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
