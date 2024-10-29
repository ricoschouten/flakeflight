{
  config,
  lib,
  inputs,
  outputs,
  src,
  ...
}:

let
  inherit (config) systems hostname username;
  inherit (lib)
    mkDefault
    mkForce
    mkOption
    genAttrs
    types
    ;

  inherit (inputs) self;

  specialArgs = {
    inherit hostname username outputs;
  };

  extraSpecialArgs = specialArgs;
in
{
  options = {
    hostname = mkOption {
      type = types.str;
      default = "nixos";
    };

    username = mkOption {
      type = types.str;
      default = "nixos";
    };
  };

  config = {
    nixDir = mkDefault src;

    nixDirAliases = {
      nixosModule = [ "configuration" ];
      homeModule = [ "home" ];
      homeConfigurations = mkForce [ ];
    };

    systems = mkDefault lib.systems.flakeExposed;

    nixosConfigurations = genAttrs systems (system: mkDefault {
      inherit system specialArgs;
      modules = [
        self.nixosModules.default
        outputs.nixosModules.default
      ];
    });

    homeConfigurations = genAttrs systems (system: mkDefault {
      inherit system extraSpecialArgs;
      modules = [
        self.homeModules.default
        outputs.homeModules.default
      ];
    });

    perSystem = pkgs:
      let
        inherit (pkgs.stdenv) hostPlatform;
      in
      {
        packages = {
          nixosConfigurations.${hostname} = outputs.nixosConfigurations.${hostPlatform.system};
          homeConfigurations.${username} = outputs.homeConfigurations.${hostPlatform.system};
        };
      };
  };
}