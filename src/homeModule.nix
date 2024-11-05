{ pkgs, inputs, ... }:

let
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.zellij
    self.homeModules.starship
    self.homeModules.helix
  ];

  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  programs = {
    fish.enable = true;
    nushell.enable = true;

    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  # programs.bash.enable = true;

  programs.starship.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.helix = {
    enable = true;

    languages = {
      language-server.nixd = {
        command = "nixd";
      };

      language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
          formatter.command = "nixfmt";
          auto-format = true;
        }
      ];
    };
  };
}
