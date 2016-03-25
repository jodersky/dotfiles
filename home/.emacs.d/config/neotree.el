(use-package neotree
  :config (progn
	    (custom-set-faces
	     '(neo-banner-face ((t :inherit shadow)) t)
	     '(neo-button-face ((t :inherit dired-directory)) t)
	     '(neo-dir-link-face ((t :inherit dired-directory)) t)
	     '(neo-expand-btn-face ((t :inherit button)) t)
	     '(neo-file-link-face ((t :inherit default)) t)
	     '(neo-header-face ((t :inherit shadow)) t)
	     '(neo-root-dir-face ((t :inherit link-visited :underline nil)) t))
	    (setq neo-theme 'ascii))
  :bind (("<f8>" . neotree-toggle)))
