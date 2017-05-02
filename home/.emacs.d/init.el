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

;; font
; value is in 1/10pt, so 100 will give you 10pt, etc.
(set-face-attribute 'default nil :height 100)

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

;; save customizations to separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq initial-buffer-choice "~/readme.org")

(defun show-file-name ()
  "Show the absolute path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key (kbd "C-x n") 'show-file-name)

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
  :diminish company-mode
  :commands company-mode)

;; Snippets
(use-package yasnippet
  :diminish yas-minor-mode
  :commands yas-minor-mode
  :config
  (define-key yas-minor-mode-map [tab] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (yas-reload-all)
  :bind ("C-<tab>" . yas-expand))

(use-package yatemplate
  :defer 2 ;; WORKAROUND https://github.com/mineo/yatemplate/issues/3
  :config
  (auto-insert-mode t)
  (setq auto-insert-alist nil)
  (yatemplate-fill-alist))

;; C
(setq c-default-style "linux")

;; Scala
(defcustom
  scala-mode-prettify-symbols
  '(("->" . ?→)
    ("<-" . ?←)
    ("=>" . ?⇒)
    ("<=" . ?≤)
    (">=" . ?≥)
    ("!=" . ?≠)
    ("implicit" . ?ⅈ))
"Prettify symbols for scala-mode.")

(use-package scala-mode
  :pin melpa
  :interpreter ("scala" . scala-mode)
  :config
  (require 'ensime-expand-region)
  (add-hook 'scala-mode-hook
	    (lambda ()
	      (setq prettify-symbols-alist scala-mode-prettify-symbols)
	      (prettify-symbols-mode t)
	      (local-set-key (kbd "RET")
			     '(lambda ()
				(interactive)
				(newline-and-indent)
				(scala-indent:insert-asterisk-on-multiline-comment)))
	      (setq fill-column 80)
	      (ensime-mode)))
  :bind (:map scala-mode-map
	      ("<backtab>" . scala-indent:indent-with-reluctant-strategy)))

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :pin melpa ;; pining to melpa uses cutting-edge snapshot version
  :commands ensime ensime-mode
  :init
  :config
  (setq ensime-startup-notification nil
	ensime-startup-snapshot-notification nil))

(use-package sbt-mode
  :pin melpa)

;; Java / Scala support for templates
(defun mvn-package-for-buffer ()
  "Calculate the expected package name for the buffer;
assuming it is in a maven-style project."
  ;; see https://github.com/fommil/dotfiles/issues/66
  (let* ((kind (file-name-extension buffer-file-name))
         (root (locate-dominating-file default-directory kind)))
    (when root
      (require 'subr-x) ;; maybe we should just use 's
      (replace-regexp-in-string
       (regexp-quote "/") "."
       (string-remove-suffix "/"
                             (string-remove-prefix
                              (expand-file-name (concat root "/" kind "/"))
                              default-directory))
nil 'literal))))

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

;;(use-package idea-darkula-theme)
;;(use-package intellij-theme)
;;(load-theme 'idea-darkula)
(load-theme 'solarized-light)
