{ config, pkgs, ... }:

{
  imports = [
    ./modules/shell.nix
  ];
  
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fastfetch
  ];
}
