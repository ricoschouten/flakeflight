{
  lib,
  inputs,
  outputs,
  hostname,
  username,
  ...
}:

let
  inherit (lib) mkDefault mkAliasOptionModule;
  inherit (inputs) self home-manager;
in
{
  imports = [
    home-manager.nixosModules.home-manager
    (mkAliasOptionModule [ "home" ] [
      "home-manager"
      "users"
      "default"
    ])
  ];

  config = {
    home-manager = {
      useGlobalPkgs = mkDefault true;
      useUserPackages = mkDefault true;

      extraSpecialArgs = {
        inherit inputs hostname username outputs;
      };
    };
    
    home-manager.users.default.imports = [
      self.homeModules.default
      outputs.homeModules.default
    ];
  };
}
