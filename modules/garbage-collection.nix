{ pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-generations +7";
  };
  nix.settings.auto-optimise-store = true;
}
