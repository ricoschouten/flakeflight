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
    self.homeModules.helix
  ];

  home.username = mkForce username;
  home.homeDirectory = mkDefault /home/${username};

  home.packages = [
    pkgs.nixd
    pkgs.nixfmt-rfc-style                                                                                 
  ];

  programs.fish.enable = true;

  # programs.bash.enable = true;

  programs.starship.enable = true;

  programs.zellij = {
    enable = true;
    # enableBashIntegration = true;
    enableFishIntegration = true;

    shellIntegration = {
      autoAttach = true;
      autoExit = true;
    };
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
