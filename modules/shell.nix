{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      nix-switch = "sudo nixos-rebuild switch --impure --flake .#nixos";
    };

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    enableCompletion = true;
    completionInit = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*:default' list-colors ""
    '';

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "Catppuccin Mocha";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;

      keybind = [
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_tab"
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };

  home.sessionVariables = {
    EDITOR = "helix";
  };
}
