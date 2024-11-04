{ inputs, ... }:

let
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.users
    self.nixosModules.home-manager
    self.nixosModules.wsl
    self.nixosModules.nh
    self.nixosModules.fish
  ];

  programs = {
    fish.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
