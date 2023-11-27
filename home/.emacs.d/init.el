;;; General editor configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
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
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono" ))
(set-face-attribute 'default t :font "Ubuntu Mono")
; value is in 1/10pt, so 100 will give you 10pt, etc.
(set-face-attribute 'default nil :height 130)

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

;; don't send emacs to background
(global-unset-key (kbd "C-z"))

;;(setq initial-buffer-choice "~/readme.org")

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-o") 'other-window)

(defun show-file-name ()
  "Show the absolute path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(global-set-key (kbd "C-x n") 'show-file-name)

(defun unfill-paragraph (&optional region)
  ;; http://www.emacswiki.org/emacs/UnfillParagraph
  "Transforms a paragraph in REGION into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil region)))
(define-key global-map "\M-Q" 'unfill-paragraph)

;;; Enable use-package

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-ensure t)

;;; Specialized packages

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-completing-read-function 'magit-ido-completing-read)
  (setq magit-save-repository-buffer 'dontask))

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

;; Completion
(use-package company
  :diminish company-mode
  :commands company-mode)

;; C
(setq c-default-style "linux")
