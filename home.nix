{ config, pkgs, ... }:

{
  imports = [
    ./modules/bluetooth-tools.nix
    ./modules/editor.nix
    ./modules/shell.nix
  ];
  
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  # ディレクトリ開発環境設定
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    bitwarden-desktop
    brave
    fastfetch
    firefox
    google-chrome
    gimp
    lact
  ];
}
