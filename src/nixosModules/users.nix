{
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

let
  inherit (lib) mkDefault mkAliasOptionModule;
  inherit (inputs) self;
in
{
  imports = [
    (mkAliasOptionModule [ "user" ] [
      "users"
      "users"
      "default"
    ])
  ];

  config = {
    users.users.default = {
      name = username;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
