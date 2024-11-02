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
      username
    ])
  ];

  config = {
    users.users.${username} = {
      isNormalUser = mkDefault true;
      extraGroups = [ "wheel" ];
    };
  };
}
