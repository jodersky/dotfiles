(use-package helm
  :config
  (progn ; progn since order is important here
    (setq helm-split-window-in-side-p t ; open helm buffer inside current windowA
	  helm-candidate-number-limit 100
	  helm-quick-update t
	  helm-M-x-requires-pattern nil
	  helm-M-x-fuzzy-match t
	  helm-buffers-fuzzy-matching t
	  helm-recentf-fuzzy-match t
	  helm-ff-file-name-history-use-recentf t))

  :bind (("C-h a" . helm-apropos)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 :map helm-map
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
	 ("C-z" . helm-select-action))

  :diminish helm-mode)

(use-package helm-descbinds
  :bind ("C-h b" . helm-descbinds))

(use-package helm-swoop
  :bind ("C-s" . helm-swoop))

(use-package helm-projectile
  :config
  (helm-projectile-on)
  :bind (("C-x p" . helm-projectile)
	 ("C-x P" . helm-projectile-grep)))

(use-package projectile
  :defer t ; loading is ensured by helm-projectile
  :init
  (setq projectile-use-git-grep t)
  :config
  (projectile-global-mode t)
  :diminish projectile-mode)

(use-package magit
  :bind ("C-x g" . magit-status))
