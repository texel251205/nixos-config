{ pkgs, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "absolute";
        cursorline = true;
        color-modes = true;
        text-width = 80;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        indent-guides.render = true;
        soft-wrap = {
          enable = true;
          wrap-at-text-width = true;
        };
        inline-diagnostics.cursor-line = "warning";
      };
    };

    languages = {
      language = [
        {
          name = "rust";
          text-width = 100;
          rulers = [ 100 ];
          soft-wrap = {
            enable = true;
            wrap-at-text-width = true;
          };
        }
      ];
      language-server.rust-analyzer.config.rustfmt.max_width = 100;
    };
  };
}
