(require 'neotree)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-banner-face ((t :inherit shadow)) t)
 '(neo-button-face ((t :inherit dired-directory)) t)
 '(neo-dir-link-face ((t :inherit dired-directory)) t)
 '(neo-expand-btn-face ((t :inherit button)) t)
 '(neo-file-link-face ((t :inherit default)) t)
 '(neo-header-face ((t :inherit shadow)) t)
 '(neo-root-dir-face ((t :inherit link-visited :underline nil)) t))

(setq neo-theme 'ascii)

(neotree)
