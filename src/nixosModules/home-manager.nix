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
      username
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
    
    home-manager.users.${username}.imports = [
      self.homeModules.default
      outputs.homeModules.default
    ];
  };
}
