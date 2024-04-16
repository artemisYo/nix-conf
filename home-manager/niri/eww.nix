{ pkgs, config, lib, ... }: let
  cfg = config.custom.eww;
in {
  options.custom.eww = with lib; {
    enable = mkEnableOption "custom eww config";
  };

  config = lib.mkIf cfg.enable {
    programs.eww.enable = true;
    programs.eww.configDir = ./eww;
    # xdg.dataHome."fonts/symbols/" = {
    #   source = pkgs.fetchzip {
    #     url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip";
    #     hash = "";
    #   };
    #   recursive = true;
    # };
    home.file.".local/share/fonts/symbols" = {
      source = pkgs.fetchzip {
        url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip";
        hash = "sha256-86iQmX9J3YpWoCVYGvlyi6A/6uJcPa2iU0MgCmekkiE=";
        stripRoot = false;
      };
      recursive = true;
    };
  };
}
