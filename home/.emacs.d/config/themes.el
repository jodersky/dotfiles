(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai-emacs")

(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (let ((mode (if (display-graphic-p frame) 'light 'dark)))
	      (set-frame-parameter frame 'background-mode mode)
	      (set-terminal-parameter frame 'background-mode mode))
	    (enable-theme 'solarized)))

(defun set-solarized-light ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'light)
  (load-theme 'solarized t))

(defun set-solarized-dark ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'dark)
  (load-theme 'solarized t))

(global-set-key [f9] 'set-solarized-light)
(global-set-key [f10] 'set-solarized-dark)


(load-theme 'monokai t)
