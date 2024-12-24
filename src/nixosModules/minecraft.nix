{ inputs, ... }:

let
  inherit (inputs) nix-minecraft;
in
{
  imports = [ nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ nix-minecraft.overlay ];
}
