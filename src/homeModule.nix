{
  lib,
  pkgs,
  inputs,
  username,
  ...
}:

let
  inherit (lib) mkDefault mkForce;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.zellij
    self.homeModules.starship
  ];

  home.username = mkForce username;
  home.homeDirectory = mkDefault /home/${username};

  home.packages = [
    pkgs.hello
  ];

  # programs.fish.enable = true;

  programs.bash.enable = true;

  programs.starship.enable = true;

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    # enableFishIntegration = true;

    shellIntegration = {
      autoAttach = true;
      autoExit = true;
    };
  };
}
