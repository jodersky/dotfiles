;;; General configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq ring-bell-function 'ignore)

;; disable backups, autosave and lockfiles (use scm instead)
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; font
(set-face-attribute 'default nil :height 110); value is in 1/10pt, so 100 will give you 10pt, etc.

;; uniform questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; default window size
(when window-system (set-frame-size (selected-frame) 160 60))

;; set title of frame to current buffer
(setq frame-title-format "%b")

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight tabulations
;(setq-default highlight-tabs t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;;; Other configuration
;(mapc 'load (file-expand-wildcards "~/.emacs.d/config/*.el"))
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
;; c style
(setq c-default-style "linux")
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
	 ("<tab>" . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action) ; make TAB works in terminal
	 ("C-x c o" . helm-occur)
	 ("C-x c y" . helm-yas-complete)
	 ("C-x c Y" . helm-yas-create-snippet-on-region)
	 ("C-x c SPC" . helm-all-mark-rings))

  :diminish helm-mode)
(use-package markdown-mode
  :mode ("\\.markdown\\'" "\\.md\\'")
  :config (setq markdown-command "/usr/bin/pandoc"))
(use-package minimap
  :config (progn
	    (setq minimap-width-fraction 0.1
		  minimap-window-location (quote right))
	    (set-face-attribute 'minimap-active-region-background nil :background "dim gray")))
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
(use-package scala-mode2
  :interpreter
  ("scala" . scala-mode)
  :config
  ;; BUG https://github.com/Fuco1/smartparens/issues/468
  ;; backwards/next not working particularly well

  ;; i.e. bypass company-mode
  (bind-key "C-<tab>" 'dabbrev-expand scala-mode-map)
  (bind-key "C-c e" 'next-error scala-mode-map)
  (add-hook 'scala-mode-hook
	    (lambda ()
	      (local-set-key (kbd "RET") '(lambda ()
					    (interactive)
					    (newline-and-indent)
					    (scala-indent:insert-asterisk-on-multiline-comment)))
	      (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)
	      (setq fill-column 100)
	      (ensime-mode))))

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :commands ensime ensime-mode
  :init
  (setq
   ensime-default-buffer-prefix "ENSIME-"))
(use-package spotify
  :bind (("M-s p" . spotify-playpause)
	 ("M-s n" . spotify-next)))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai-emacs")

(when (display-graphic-p)
  (load-theme 'monokai t))
(use-package web-mode
  :mode ("\\.phtml\\'"
	 "\\.tpl\\.php'"
	 "\\.[agj]sp'"
	 "\\.as[cp]x'"
	 "\\.erb'"
	 "\\.mustache'"
	 "\\.djhtml'"
	 "\\.html?\\'"))
