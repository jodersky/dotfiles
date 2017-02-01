;;; General editor configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)

;; disable backups, autosave and lockfiles
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; save customizations to separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; font
(set-face-attribute 'default nil :height 100); value is in 1/10pt, so 100 will give you 10pt, etc.

;; simplify questions
(defalias 'yes-or-no-p 'y-or-n-p)
(setq vc-follow-symlinks t)

;; kill the current buffer immediately (only ask if buffer modified)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; set title of frame to current buffer
(setq frame-title-format '(buffer-file-name "%f" "%b"))

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Show directories first
(setq dired-listing-switches "-alh  --group-directories-first")

;;; Enable use-package

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-ensure t)

;;; Specialized packages

(use-package helm
  :config
  (progn ; progn since order is important here
    (setq helm-candidate-number-limit 100
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
  :config (setq helm-swoop-pre-input-function
		(lambda () ""))
  :bind ("C-s" . helm-swoop))

(use-package helm-projectile
  :config
  (helm-projectile-on)
  :bind (("C-x p" . helm-projectile)
	 ("C-x P" . helm-projectile-grep)))

(use-package goto-chg
  :commands goto-last-change
  :bind (("C-." . goto-last-change)
         ("C-," . goto-last-change-reverse)))

(use-package popup-imenu
  :commands popup-imenu
  :bind ("M-i" . popup-imenu))

(use-package projectile
  :defer t ; loading is ensured by helm-projectile
  :init
  (setq projectile-use-git-grep t)
  :config
  (projectile-global-mode t)
  :diminish projectile-mode)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package zoom-frm
  :bind (("C-+" . zoom-all-frames-in)
	 ("C--" . zoom-all-frames-out)
	 ("C-0" . zoom-frm-unzoom)))

(use-package expand-region
  :commands 'er/expand-region
  :bind ("C-=" . er/expand-region))

(defun unfill-paragraph (&optional region)
  ;; http://www.emacswiki.org/emacs/UnfillParagraph
  "Transforms a paragraph in REGION into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))
(define-key global-map "\M-Q" 'unfill-paragraph)

(defun revert-buffer-no-confirm ()
  ;; http://www.emacswiki.org/emacs-en/download/misc-cmds.el
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t))
(global-set-key [f5] 'revert-buffer-no-confirm)

;; Markdown
(use-package markdown-mode
  :mode
  ("\\.markdown\\'" "\\.md\\'")
  :config
  (setq markdown-command "/usr/bin/pandoc"))

;; YML
(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

;; Completion
(use-package company
  :diminish company-mode)

;; Snippets
(use-package yasnippet
  :diminish yas-minor-mode)

;; C
(setq c-default-style "linux")

;; Scala
(use-package scala-mode
  :interpreter ("scala" . scala-mode)
  :config
  (require 'ensime-expand-region)
  (add-hook 'scala-mode-hook
	    (lambda ()
	      (local-set-key (kbd "RET")
			     '(lambda ()
				(interactive)
				(newline-and-indent)
				(scala-indent:insert-asterisk-on-multiline-comment)))
	      (setq fill-column 80)
	      (ensime-mode)))
  :bind (:map scala-mode-map
	      ("C-<tab>" . dabbrev-expand)
	      ("<backtab>" . scala-indent:indent-with-reluctant-strategy)))

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :pin melpa ;; pining to melpa uses cutting-edge snapshot version
  :commands ensime ensime-mode
  :init
  :config
  (setq ensime-startup-notification nil
	ensime-startup-snapshot-notification nil))

;; Java
(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4)))
;; Rust
(use-package rust-mode
  :mode "\\.rs\\'")
(use-package toml-mode
  :mode "\\.toml\\'")

;; Web development
;; Different modes in html files
(use-package web-mode
  :mode "\\.html?\\'")

;; Javascript
(use-package js3-mode
  :mode "\\.js\\'")

;; Haskell
(use-package haskell-mode)

;; Docker
(use-package dockerfile-mode
  :mode "\\Dockerfile\\'")

(use-package spotify
  :bind (("M-s SPC" . spotify-playpause)
	 ("M-s p" . spotify-previous)
	 ("M-s n" . spotify-next)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai-emacs")
(load-theme 'monokai t)
