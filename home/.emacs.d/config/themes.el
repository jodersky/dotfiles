(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai-emacs")

(when (display-graphic-p)
  (load-theme 'monokai t))
