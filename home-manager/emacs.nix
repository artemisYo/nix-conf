{ pkgs, ... }: let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};

  tex = (pkgs.texlive.combine { inherit (pkgs.texlive)
    scheme-basic dvisvgm dvipng
    wrapfig amsmath ulem hyperref capt-of
  ;});
in {
  imports = 
    [ nur-no-pkgs.repos.rycee.hmModules.emacs-init 
    ];
  home.packages =
    [ pkgs.fira-code
      tex
    ];

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;
    startupTimer = true;
    earlyInit = ''
      (push '(menu-bar-lines . 0) default-frame-alist)
      (push '(tool-bar-lines . nil) default-frame-alist)
      (push '(vertical-scroll-bars . nil) default-frame-alist)

      (set-face-attribute 'default
                          nil
                          :height 180
                          :family "Fira Code")
    '';
    prelude = ''
      (setq inhibit-startup-screen t
            initial-scratch-message nil
            make-backup-files nil
            auto-save-default nil
            scroll-step 1
            scroll-conservatively 5
            select-enable-clipboard t
            select-enable-primary t
            save-interprogram-paste-before-kill t
            ring-bell-function 'ignore
            display-line-numbers-type 'relative)
      (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
      (setq-default indent-tab-mode nil
                    tab-width 4
                    c-basic-offset 4)
      (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
      (add-hook 'prog-mode-hook 'line-number-mode)

      (defalias 'yes-or-no-p 'y-or-n-p)

      (add-to-list 'custom-theme-load-path "${builtins.fetchTree {
        type = "sourcehut";
        owner = "~theorytoe";
        repo = "everforest-theme";
        rev = "703b16b742b753f6ad077b5c7f51947d1926c530";
      }}")
      (load-theme 'everforest-hard-dark t)
    '';
    usePackage = {
      nix-mode.enable = true;
      # emacs101: install package from git
      # app-launcher = {
      #   enable = true;
      #   package = epkgs:
      #     epkgs.trivialBuild {
      #       pname = "app-launcher.el";
      #       src = pkgs.fetchurl {
      #         url = "https://raw.githubusercontent.com/SebastienWae/app-launcher/main/app-launcher.el";
      #         hash = "sha256-PDjYI2jrdis/X72oFE/uMdN4MpgzuI6HAB5X1jnBl24=";
      #       };
      #       version = "0.1.0";
      #     };
      # };
    };
  };
  programs.emacs.enable = true;
  services.emacs.defaultEditor = true;
  programs.emacs.package = (pkgs.emacs29.override {
    withNativeCompilation = true;
    withTreeSitter = true;
    withPgtk = true;
  });
}
