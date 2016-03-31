(use-package helm
  :init (progn
	  (require 'helm-config)
	  (helm-mode t)

	  (use-package helm-ag
	    :ensure    helm-ag
	    :bind      ("C-c a" . helm-ag))

	  (use-package helm-descbinds
	    :ensure    helm-descbinds
	    :bind      ("C-h b"   . helm-descbinds))

	  (use-package helm-projectile
	    :ensure    helm-projectile
	    :bind      ("C-c h" . helm-projectile))

	  (use-package helm-swoop
	    :ensure    helm-swoop
	    :bind      (("C-c o" . helm-swoop)
			("C-c M-o" . helm-multi-swoop)))

	  (bind-key "C-c C-SPC" 'helm-ff-run-toggle-auto-update helm-find-files-map))

  :config (setq helm-candidate-number-limit 100
		helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
		helm-input-idle-delay 0.01  ; this actually updates things reeeelatively quickly.
		helm-yas-display-key-on-candidate t
		helm-quick-update t
		helm-M-x-requires-pattern nil
		helm-ff-skip-boring-files t
		helm-split-window-in-side-p t ; open helm buffer inside current window
		helm-M-x-fuzzy-match t
		helm-buffers-fuzzy-matching t
		helm-recentf-fuzzy-match t
		helm-ff-file-name-history-use-recentf t)

  :bind (("C-c h" . helm-mini)
	 ("C-h a" . helm-apropos)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 ("C-x c o" . helm-occur)
	 ("C-x c y" . helm-yas-complete)
	 ("C-x c Y" . helm-yas-create-snippet-on-region)
	 ("C-x c SPC" . helm-all-mark-rings)
	 :map helm-map
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
	 ("C-z" . helm-select-action))

  :diminish helm-mode)


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
