(use-package projectile
  :diminish projectile-mode
  :config (progn
	    (setq projectile-keymap-prefix (kbd "C-c p"))
	    (setq projectile-completion-system 'default)
	    (setq projectile-enable-caching t)
	    (setq projectile-indexing-method 'alien)
	    (add-to-list 'projectile-globally-ignored-files "node-modules")
	    (projectile-global-mode)
	    (helm-projectile-on)))

(use-package helm-projectile)
