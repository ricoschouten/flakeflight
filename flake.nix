{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use Home Manager for all user-scoped configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = { flakelight, ... }@inputs:
    flakelight ./src {
      imports = [ flakelight.flakelightModules.flakelightModule ];

      flakelightModule = {
        inherit inputs;
      };
    };
}
