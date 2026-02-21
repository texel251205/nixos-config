{ pkgs, lib, ...}:

{
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "google-chrome"
      "obsidian"
      "steam"
      "steam-unwrapped"
    ];
  };
}
